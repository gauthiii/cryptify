import 'package:flutter/material.dart';
import './encryption.dart';

class Ver extends StatefulWidget {
  final User user;

  Ver({required this.user});

  @override
  Decoder createState() {
    return new Decoder();
  }
}

class Decoder extends State<Ver> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  String _displayValue = "";

  @override
  void initState() {
    super.initState();

    _textFieldController1.text = widget.user.a;
    _textFieldController2.text = widget.user.b;
  }

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
        backgroundColor: Colors.grey[900],
        title: const Text("MESSAGE DECRYPTION",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: _getColorFromHex("#971208"),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Container(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  minLines: 1,
                  maxLines: null,
                  style: const TextStyle(
                    fontFamily: "Alfa",
                    fontSize: 18,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold
                  ),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: "Mono",
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 29, 24, 24)),
                    hintText: 'Enter your Cryptic Message',
                  ),
                  controller: _textFieldController1,
                )),
            Container(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  minLines: 1,
                  maxLines: null,
                  style: const TextStyle(
                    fontFamily: "Alfa",
                    fontSize: 18,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold
                  ),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.5),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: "Mono",
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 29, 24, 24)),
                    hintText: 'Enter your Secret Key',
                  ),
                  controller: _textFieldController2,
                )),
            Container(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 1.0,
                ),
                child: const Text("DECRYPT THE MESSAGE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 16.0,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  decrypt(_textFieldController1.text.trim(),
                      _textFieldController2.text.trim());
                },
              ),
            ),
            Container(height: 30),
            (_displayValue.trim().isEmpty)
                ? Column(children: [
                    const SizedBox(
                      height: 200,
                      child: Center(
                          child: Icon(
                        Icons.lock_open,
                        color: Colors.black,
                        size: 256,
                      )),
                    ),
                    Container(height: 100),
                    const Center(
                        child: SelectableText("DECRYPTION",
                            style: TextStyle(
                                fontFamily: "Alfa",
                                fontSize: 30.0,
                                color: Colors.black))),
                  ])
                : Column(children: [
                    const Text("THE ORIGINAL MESSAGE\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Mono',
                          fontSize: 17.0,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold
                        )),
                    SelectableText(_displayValue,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Alfa',
                            fontSize: 25.0,
                            color: Colors.black)),
                    const Text(""),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                elevation: 1.0,
                              ),
                              child: const Text("RESET",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Mono",
                                      fontSize: 16.0,
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              })),
                    ]),
                    Container(height: 20),
                    const Center(
                      child: Icon(
                        Icons.lock_open,
                        size: 150,
                        color: Colors.black,
                      ),
                    )
                  ])
          ],
        ),
      ),
    );
  }
}

_getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";

    return Color(int.parse("0x$hexColor"));
  }

  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}
