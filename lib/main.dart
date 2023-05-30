import 'package:cryptify/verify.dart';
import 'package:flutter/material.dart';
import './decryption.dart';
import './encryption.dart';
import './about.dart';
import './alg.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

List imgL = [
  'images/a5.png',
  'images/a2.png',
  'images/a1.png',
  'images/a3.png'
];

List<String> tL = ['ABOUT APP', 'ALGORITHM', 'ENCRYPTION', 'DECRYPTION'];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptify',
      theme: ThemeData.dark(),
      home: FirstRoute(),
    );
  }
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => F();
}

class F extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: const SelectableText('MESSAGE ENCRYPTER-DECRYPTER',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: _getColorFromHex("#971208"),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          const Center(
              child: SelectableText("\nClick the Hamburger icon to view menu",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          Container(height: 70),
          const Icon(
            Icons.lock,
            size: 256,
            color: Colors.black,
          ),
          Container(height: 50),
          const Center(
              child: SelectableText("CRYPTIFY",
                  style: TextStyle(
                      fontFamily: "Alfa",
                      fontSize: 30.0,
                      color: Colors.black))),
          Container(height: 150),
          const Center(
              child: SelectableText(
                  "App Developed By: Gauthiii's Applications\n",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('MENU'),
            ),
            ListTile(
              title: const Text('About App'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
            ListTile(
              title: const Text('The Algorithm'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Alg()),
                );
              },
            ),
            ListTile(
              title: const Text('Message Encryption'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Encryptor()),
                );
              },
            ),
            ListTile(
              title: const Text('Message Decryption'),
              onTap: () {
                User user = User("", "");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ver(
                            user: user,
                          )),
                );
              },
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
