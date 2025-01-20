import 'package:blogly/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import '../widgets/textInput.dart';
import '../widgets/blog_input.dart';

class CreateBlog extends StatelessWidget {
  const CreateBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a blog",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back), color: Colors.lightBlueAccent,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputForm(form: "Enter the title of the blog"),
          SizedBox(height: 10.0,),
          InputForm(form: "Enter the subtitle of the blog"),
          SizedBox(height: 10.0),
          BlogInput(),
          SizedBox(height: 20.0),
          SubmitButton(form: "Submit your Blog")
        ],
      ),
    );
  }
}
