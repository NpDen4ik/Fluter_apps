import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


// Future<http.Response> postRequest () async {
//   var url = 'http://192.168.100.113:3000/users/sign_in';

//     Map data = {
//        'user': {
//          'email': "NpDen4ik@yandex.ru",
//          'password': "NpDen4ik123"
//        }
//     };
//   //encode Map to JSON
//   var body = json.encode(data);

//   var response = await http.post(url,
//       headers: {"Content-Type": "application/json"},
//       body: body
//   );
//   //print("${response.statusCode}");
//  // print("${response.body}");
//   print("${response.headers['authorization']}");
//   return response;
// }
//

Future<http.Response> join_postRequest (String email, String password) async {
  var url = 'http://192.168.100.113:3000/users/sign_in';
    Map data = {
       'user': {
         'email': email,
         'password': password
       }
    };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  //print("${response.statusCode}");
 // print("${response.body}");
  print("${response.headers['authorization']}");
  return response;
}


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final emailController = new TextEditingController();
    final passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          join_postRequest (emailController.text, passwordController.text);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}