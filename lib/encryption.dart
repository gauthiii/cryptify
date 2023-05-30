import 'package:flutter/material.dart';
import 'package:rsis/rsis.dart';
import './verify.dart';

class User {
  String a, b;

  User(this.a, this.b);
}

class Encryptor extends StatefulWidget {
  const Encryptor({super.key});

  @override
  Encoder createState() {
    return Encoder();
  }
}

class Encoder extends State<Encryptor> {
  final TextEditingController _textFieldController = TextEditingController();
  String _displayValue = "";
  String k = "";

  encrypt(String value) {
    /* int fl, hl, fl1, fl2, hl1, hl2;
    var str = value;
    var str1, str2, str3;
    print(str);

    fl = str.length;
    hl = (fl / 2).toInt();

    str1 = str.substring(0, hl);
    if (fl % 2 == 0)
      str2 = str.substring(hl, fl);
    else {
      str2 = str.substring(hl + 1, fl);
      str3 = str.substring(hl, hl + 1);
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
      str1 = str5.split('').reversed.join() + str4;
    else
      str1 = str5.split('').reversed.join() + str6 + str4;

    if (fl2 % 2 == 0)
      str2 = str8.split('').reversed.join() + str7;
    else
      str2 = str8.split('').reversed.join() + str9 + str7;

    if (fl % 2 == 0)
      str = str2 + str1;
    else
      str = str2 + str3 + str1;

    print(str);

    var enc = "";
    var key = "";

    for (int i = 0; i < fl; i++) {
      num d, e, s = 0;
      d = str.codeUnitAt(i);

      while (d > 0) {
        e = d % 10;
        s += e;
        d = (d / 10).toInt();
      }
      key += s.toString() + "-";
      var x;
      x = str.codeUnitAt(i) + ((i + 1) * s);
      x = x % 94;
      x = x + 32;

      enc += String.fromCharCode(x);
    }

    key = key.substring(0, (key.length - 1));
//enc=enc+"\n\nKEY:\n\n"+key;

    setState(() {
      _displayValue = enc;

      k = key;
    });
    */

    setState(() {
      List<String> enc = Rsis.encrypt(text: value).split('(0)');
      _displayValue = enc[0];

      k = enc[1];
    });
  }

  void _reset() {
    _textFieldController.text = '';
    _displayValue = "";
    k = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: const Text("MESSAGE ENCRYPTION",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: _getColorFromHex("#971208"),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
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
                    hintText: 'Enter your Message',
                  ),
                  controller: _textFieldController,
                )),
            Container(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 1.0,
                ),
                child: const Text("ENCRYPT THE MESSAGE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mono",
                        fontSize: 16.0,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  encrypt(_textFieldController.text.trim());
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
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 256,
                      )),
                    ),
                    Container(height: 100),
                    const Center(
                        child: SelectableText("ENCRYPTION",
                            style: TextStyle(
                                fontFamily: "Alfa",
                                fontSize: 30.0,
                                color: Colors.black))),
                  ])
                : Column(children: [
                    const Text("THE ENCRYPTED MESSAGE\n",
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
                    const Text("\nTHE KEY GENERATED\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Mono',
                          fontSize: 17.0,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold
                        )),
                    SelectableText(k,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Alfa',
                            fontSize: 25.0,
                            color: Colors.black)),
                    const Text(""),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                          SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    elevation: 1.0,
                                  ),
                                  child: const Text("DECRYPT",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Mono",
                                          fontSize: 16.0,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  onPressed: () {
                                    setState(() {
                                      _navigateHome(context);
                                    });
                                  })),
                        ]),
                    Container(height: 20),
                    const Center(
                      child: Icon(
                        Icons.lock_outline,
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

  _navigateHome(BuildContext context) async {
    String x, y;
    x = _displayValue;
    y = k;
    User user = User(x, y);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Ver(
                  user: user,
                )));
    print(result);
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
