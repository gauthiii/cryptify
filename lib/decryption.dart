import 'package:flutter/material.dart';
import './encryption.dart';
import './main.dart';
import './about.dart';
import './alg.dart';

void main() => runApp(Decryptor());

class Decryptor extends StatefulWidget {
  @override
  Decoder createState() {
    return new Decoder();
  }
}

class Decoder extends State<Decryptor> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  String _displayValue = "";

  decrypt(String t1, String t2) {
    var str = t1;
    var key = t2;
    int k, pos;
    var dec = "";
    key += "-";

    int r = 0;

    for (int b = 0; b < key.length; b++) if (key[b] == '-') r++;

    if (str.length == 0 ||
        key.length == 0 ||
        (str.length == 0 && key.length == 0))
      dec =
          "Please fill both the fields!\nYou can't decrypt a message without a message AND you need a key to perform the reverse Algorithm!";
    else if (str.length != r)
      dec = "Incorrect Entry!\nKEY length doesn't match the message length";
    else {
      pos = 0;
      for (int i = 0; i < str.length; i++) {
        var d;
        d = str.codeUnitAt(i);
        d = d - 32;
        var kc = "";
        for (k = pos; k < key.length; k++) {
          int x = key.codeUnitAt(k);
          if (key[k] != '-')
            kc += String.fromCharCode(x);
          else
            break;
        }
        pos = k + 1;

        int y = int.parse(kc);
        d = d - ((i + 1) * y);
        d = d % 94;

        if (d < 32) d += 94;

        dec += String.fromCharCode(d);
      }
      print(dec);

      int fl, hl, fl1, fl2, hl1, hl2;
      var str1, str2, str3;

      fl = dec.length;
      hl = (fl / 2).toInt();

      str1 = dec.substring(0, hl);
      if (fl % 2 == 0)
        str2 = dec.substring(hl, fl);
      else {
        str2 = dec.substring(hl + 1, fl);
        str3 = dec.substring(hl, hl + 1);
      }

      var str4, str5, str6;
      fl1 = str1.length;
      hl1 = (fl1 / 2).toInt();

      str4 = str1.substring(0, hl1);
      if (fl1 % 2 == 0)
        str5 = str1.substring(hl1, fl1);
      else {
        str5 = str1.substring(hl1 + 1, fl1);
        str6 = str1.substring(hl1, hl1 + 1);
      }

      var str7, str8, str9;
      fl2 = str2.length;
      hl2 = (fl1 / 2).toInt();

      str7 = str2.substring(0, hl2);
      if (fl2 % 2 == 0)
        str8 = str2.substring(hl2, fl2);
      else {
        str8 = str2.substring(hl2 + 1, fl2);
        str9 = str2.substring(hl2, hl2 + 1);
      }

      if (fl1 % 2 == 0)
        str1 = str5 + str4.split('').reversed.join();
      else
        str1 = str5 + str6 + str4.split('').reversed.join();

      if (fl2 % 2 == 0)
        str2 = str8 + str7.split('').reversed.join();
      else
        str2 = str8 + str9 + str7.split('').reversed.join();

      if (fl % 2 == 0)
        dec = str2 + str1;
      else
        dec = str2 + str3 + str1;
    }

    print(dec);
    setState(() {
      _displayValue = dec;
    });
  }

  void _reset() {
    _textFieldController1.text = '';
    _textFieldController2.text = '';
    _displayValue = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MESSAGE DECRYPTION",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Text("\n\nENTER THE MESSAGE YOU WANT TO DECRYPT\n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Message'),
              controller: _textFieldController1,
            ),
            Text("\nENTER THE KEY\n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Key'),
              controller: _textFieldController2,
            ),
            Text("\n"),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange[900],
                  elevation: 1.0,
                ),
                child: Text("DECRYPT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  decrypt(
                      _textFieldController1.text, _textFieldController2.text);
                },
              ),
            ),
            Text("\n\nTHE DECRYPTED MESSAGE IS:\n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            Text(_displayValue,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 25.0,
                    color: Colors.black)),
            Text(""),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange[900],
                    elevation: 1.0,
                  ),
                  child: Text("RESET",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      _reset();
                    });
                  }),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('MENU'),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            ListTile(
              title: Text('About App'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
            ListTile(
              title: Text('The Algorithm'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Alg()),
                );
              },
            ),
            ListTile(
              title: Text('Message Encryption'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Encryptor()),
                );
              },
            ),
            ListTile(
              title: Text('Message Decryption'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Decryptor()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
