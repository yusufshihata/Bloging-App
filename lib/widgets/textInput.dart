import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  final String form;
  const InputForm({super.key, required this.form});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final InputController = TextEditingController();

  @override
  void dispose() {
    InputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: TextField(
        controller: InputController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(width: 3.0, color: Colors.lightBlueAccent),
          ),
          hintText: "Enter your ${widget.form}",
        ),
      ),
    );
  }
}

