import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF27292A),
      ),
      backgroundColor: Color(0xFF2B2D31),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Create an account\n",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: "Lato",
                    ),
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
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
                  obscureText: !_isPasswordVisible,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: RichText(
                      text: TextSpan(
                        text: "Регистрируясь, Вы соглашаетесь ",
                        style: TextStyle(
                          color: Color(0xFF898C92),
                          fontSize: 13.0,
                          fontFamily: "Lato",
                        ),
                        children: [
                          TextSpan(
                            text:
                                "с Условиями\n использования и Политикой конфиденциальности",
                            style: TextStyle(
                              color: Color(0xFF3F48CC),
                              fontSize: 13.0,
                              fontFamily: "Lato",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.only(top: 24),
                //   alignment: Alignment.topLeft,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       "Регистрируясь, Вы соглашаетесь ",
                //       style: TextStyle(
                //         color: Color(0xFF898C92),
                //         fontSize: 14.0,
                //         fontFamily: "Lato",
                //       ),
                //       children: [
                //         TextSpan(
                //           text: "с Условиями\n использования и Политикой конфиденциальности",
                //           style: TextStyle(
                //             color: Color(0xFF3F48CC),
                //             fontSize: 14.0,
                //             fontFamily: "Lato",
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 200),
                      child: FloatingActionButton.extended(
                        onPressed: () {},
                        label: Text(
                          'Entrance',
                          style: TextStyle(fontFamily: "Lato"),
                        ),
                        backgroundColor: Color(0xFF3F48CC),
                      ),
                    ),
                    // Container(
                    //   child: FloatingActionButton.extended(
                    //     onPressed: navigateToAddPage,
                    //     label: Text(
                    //       'Register',
                    //       style: TextStyle(fontFamily: "Lato"),
                    //     ),
                    //     backgroundColor: Color(0xFF3F48CC),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
