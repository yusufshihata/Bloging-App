import 'package:flutter/material.dart';
import '../services/firestore.dart'; // Import the Firestore service
import '../models/blog.dart';

class BlogDetailScreen extends StatelessWidget {
  final String id;

  const BlogDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Blog Details",
          style: TextStyle(fontFamily: "Poppins", color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Blog?>(
        future: firestoreService.getBlog(id), // Fetch the blog by ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Loading State
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error fetching blog: ${snapshot.error}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  fontFamily: "Poppins",
                ),
              ),
            ); // Error State
          }

          if (snapshot.hasData && snapshot.data != null) {
            Blog blog = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Subtitle
                  Text(
                    blog.subtitle,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Description
                  Text(
                    blog.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Content
                  Text(
                    blog.content,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Timestamp
                  Text(
                    "Posted on: ${blog.timestamp.toLocal()}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Add logic for liking the blog
                          debugPrint('Liked blog: ${blog.title}');
                        },
                        icon: const Icon(Icons.thumb_up, color: Colors.white),
                        label: const Text("Like", style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          textStyle: const TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Add logic for sharing the blog
                          debugPrint('Shared blog: ${blog.title}');
                        },
                        icon: const Icon(Icons.share, color: Colors.white,),
                        label: const Text("Share", style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          textStyle: const TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text(
              "Blog not found",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: "Poppins",
              ),
            ),
          ); // Blog Not Found State
        },
      ),
    );
  }
}
