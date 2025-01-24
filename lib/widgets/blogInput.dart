import 'package:flutter/material.dart';
import '../services/firestore.dart';

class InputForm extends StatefulWidget {
  final String form;
  final String userId;
  final String userName;
  final String userEmail;

  const InputForm({
    super.key,
    required this.form,
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Title Field
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please add a title.";
                }
                return null;
              },
              onSaved: (value) {
                title = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Blog Title",
              ),
            ),
            const SizedBox(height: 10.0),

            // Subtitle Field
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please add a subtitle.";
                }
                return null;
              },
              onSaved: (value) {
                subtitle = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Blog Subtitle",
              ),
            ),
            const SizedBox(height: 10.0),

            // Description Field
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please add a description.";
                }
                return null;
              },
              onSaved: (value) {
                description = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Blog Description",
              ),
            ),
            const SizedBox(height: 10.0),

            // Content Field
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please add content.";
                }
                return null;
              },
              onSaved: (value) {
                content = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Blog Content",
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20.0),

            // Submit Button
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  try {
                    await firestoreService.addBlog(
                      title: title,
                      subtitle: subtitle,
                      description: description,
                      content: content,
                      userId: widget.userId,
                      userName: widget.userName,
                      userEmail: widget.userEmail,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Blog added successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Navigate back
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to add blog: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text("Add Blog"),
            ),
          ],
        ),
      ),
    );
  }
}
