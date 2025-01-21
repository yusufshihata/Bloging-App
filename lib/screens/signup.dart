import 'package:flutter/material.dart';
import '../widgets/blogInput.dart';
import '../widgets/submit_button.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back to ",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "BlogLy",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 30.0,
                    color: Colors.lightBlueAccent,
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "This is a blogging application where you can write blogs about what you think.",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: "Poppins",
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]
            ),
            SizedBox(height: 35.0,),
            InputForm(form: "username"),
            SizedBox(height: 35.0,),
            InputForm(form: "Email"),
            SizedBox(height: 20.0,),
            InputForm(form: "Password"),
            SizedBox(height: 20.0),
          ]
      ),
    );
  }
}