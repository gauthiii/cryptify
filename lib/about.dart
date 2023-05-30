import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: const Text('ABOUT THE APP',
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: _getColorFromHex("#971208"),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            const SelectableText(
                "You can use this app to encrypt plaintext and decrypt cryptic messages.\n\nThe App uses RSIS algorithm to perform the encryption and decryption. The algorithm was developed by Gautham Vijayaraj in 2019.\n\nVisit the encryption or decryption page to encrypt or decrypt messages. Visit the Algorithm page to know more about the algorithm!",
                style: TextStyle(
                    fontFamily: "Mono", fontSize: 15.0, color: Colors.black)),
            Container(height: 60),
            const Icon(
              Icons.lock,
              size: 256,
              color: Colors.black,
            ),
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
