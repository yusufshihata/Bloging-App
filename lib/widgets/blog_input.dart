import 'package:flutter/material.dart';

class BlogInput extends StatefulWidget {
  const BlogInput({super.key});

  @override
  State<BlogInput> createState() => _BlogInputState();
}

class _BlogInputState extends State<BlogInput> {
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
        child: Expanded(
            child: TextField(
              controller: InputController,
              maxLines: null, // Allows unlimited lines
              keyboardType: TextInputType.multiline, // Adapts the keyboard for large text input
              decoration: InputDecoration(
                hintText: "Enter your blog",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 3.0, color: Colors.lightBlueAccent),
                ),
              ),
            )
        )
    );
  }
}
