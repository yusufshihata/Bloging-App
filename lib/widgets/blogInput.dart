import 'package:flutter/material.dart';
import '../services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InputForm extends StatefulWidget {
  final String form;
  const InputForm({super.key, required this.form});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();

  String? title;
  String? subtitle;
  String? description;
  String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Add String Please";
                }
                return null;
              },
              onSaved: (String? value) { title = value; },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Blog Title",
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Add String Please";
                }
                return null;
              },
                onSaved: (String? value) { subtitle = value; },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Blog subtitle"
              )
            ),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Add String Please";
                  }
                  return null;
                },
                onSaved: (String? value) { description = value; },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Blog description"
                )
            ),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Add String Please";
                  }
                  return null;
                },
                onSaved: (String? value) { content = value; },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Blog content"
                )
            ),
            ElevatedButton(onPressed: () {
              if(_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                firestoreService.addBlog(title, subtitle, description, content);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Processing Data")),
                );
              }

              Navigator.pop(context);
            }, child: Text("Add Blog"))
          ],
        ),
      ),
    );
  }
}
