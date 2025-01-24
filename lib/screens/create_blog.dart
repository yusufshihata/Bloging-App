import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Blog"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  "Add a New Blog",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title TextField
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (value) => title = value,
                decoration: InputDecoration(
                  labelText: "Blog Title",
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle TextField
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a subtitle";
                  }
                  return null;
                },
                onSaved: (value) => subtitle = value,
                decoration: InputDecoration(
                  labelText: "Blog Subtitle",
                  prefixIcon: const Icon(Icons.subtitles),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description TextField
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
                onSaved: (value) => description = value,
                decoration: InputDecoration(
                  labelText: "Blog Description",
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Content TextField
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the content";
                  }
                  return null;
                },
                onSaved: (value) => content = value,
                maxLines: 5, // Suitable for longer text
                decoration: InputDecoration(
                  labelText: "Blog Content",
                  prefixIcon: const Icon(Icons.article),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Check if the user is logged in
                    if (currentUser == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("You must be signed in to create a blog."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Check if displayName is set
                    if (currentUser.displayName == null || currentUser.displayName!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Your profile name is not set. Please update your profile first."),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }

                    try {
                      // Add the blog with user details
                      await firestoreService.addBlog(
                        title: title,
                        subtitle: subtitle,
                        description: description,
                        content: content,
                        userId: currentUser.uid, // Add user ID
                        userName: currentUser.displayName!, // Use display name
                        userEmail: currentUser.email ?? "No email", // Optional email
                      );

                      reloadBlogs(); // Reload blogs after adding
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Blog added successfully!")),
                      );
                      Navigator.pop(context); // Close the CreateBlog screen
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text(
                  "Add Blog",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
