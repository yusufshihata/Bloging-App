import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String form;
  const SubmitButton({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          )
        ),

      ),
      child: Text(form),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}