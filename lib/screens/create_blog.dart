import 'package:flutter/material.dart';
import '../services/firestore.dart';

class CreateBlog extends StatelessWidget {
  final Function reloadBlogs; // Callback to reload blogs

  CreateBlog({super.key, required this.reloadBlogs});

  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();

  String? title;
  String? subtitle;
  String? description;
  String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Blog")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (value) => title = value,
                decoration: InputDecoration(hintText: "Blog Title"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a subtitle";
                  }
                  return null;
                },
                onSaved: (value) => subtitle = value,
                decoration: InputDecoration(hintText: "Blog Subtitle"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                onSaved: (value) => description = value,
                decoration: InputDecoration(hintText: "Blog Description"),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter content";
                  }
                  return null;
                },
                onSaved: (value) => content = value,
                decoration: InputDecoration(hintText: "Blog Content"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await firestoreService.addBlog(title, subtitle, description, content);
                    reloadBlogs(); // Reload blogs after adding
                    Navigator.pop(context); // Close the CreateBlog screen
                  }
                },
                child: Text("Add Blog"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
