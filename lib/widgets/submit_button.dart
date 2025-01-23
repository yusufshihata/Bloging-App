import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String form;
  final VoidCallback onPressed;
  const SubmitButton({super.key, required this.form, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlueAccent),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          )
        ),

      ),
      onPressed: onPressed,
      child: Text(form),
    );
  }
}