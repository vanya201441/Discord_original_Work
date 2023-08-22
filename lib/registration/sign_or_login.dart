// import 'dart:convert';
//
// import 'package:exzample_trener_ori/registration/sign.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
//
// class Entrypage extends StatefulWidget {
//   const Entrypage({super.key});
//
//   @override
//   State<Entrypage> createState() => _EntrypageState();
// }
//
// class _EntrypageState extends State<Entrypage> {
//   @override
//   Widget build(BuildContext context) {
//     final String assetNamePath = 'assets/image/RedSoft.jpg';
//     Image imageFromAsset = Image.asset(assetNamePath, fit: BoxFit.fitHeight,);
//     return Scaffold(
//       backgroundColor: Color(0xFF2B2D31),
//       body: Container(
//         // child: imageFromAsset,
//       ),
//     );
//   }
// }
//

import 'package:exzample_trener_ori/registration/sign.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2B2D31),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Welcome back!\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontFamily: "Lato",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Text(
                "We're very happy to see you",
                style: TextStyle(
                  color: Color(0xFF898C92),
                  fontSize: 20.0,
                  fontFamily: "Lato",
                ),
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xFF3F48CC),
                  size: 27,
                ),
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  color: Color(0xFF3F48CC),
                  fontFamily: "Lato",
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF3F48CC),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF3F48CC),
                  size: 27,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Color(0xFF3F48CC),
                  fontFamily: "Lato",
                ),
                border: UnderlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            // SizedBox(height: 60),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot password?',
                  style:
                      TextStyle(fontFamily: "Lato", color: Color(0xFF3F48CC)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text(
                      'Entrance',
                      style: TextStyle(fontFamily: "Lato"),
                    ),
                    backgroundColor: Color(0xFF3F48CC),
                  ),
                ),
                Container(
                  child: FloatingActionButton.extended(
                    onPressed: navigateToAddPage,
                    label: Text(
                      'Register',
                      style: TextStyle(fontFamily: "Lato"),
                    ),
                    backgroundColor: Color(0xFF3F48CC),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => Sign(),
    );
    Navigator.push(context, route);
  }
}
