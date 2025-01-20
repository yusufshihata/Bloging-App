import 'package:flutter/material.dart';
import './login.dart';
import './signup.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          }, child: Text("Login")),
          SizedBox(height: 20.0,),
          ElevatedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Signup()),
            );
          }, child: Text("Sign up")),
        ],
      ),
    );
  }
}
