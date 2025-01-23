import 'package:blogly/screens/blogDetailScreen.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final String id; // Unique identifier for the blog
  final String title;
  final String subtitle;
  final String description;
  final VoidCallback onLikePressed;
  final VoidCallback onSharePressed;

  const BlogCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.onLikePressed,
    required this.onSharePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(id: id), // Navigate to BlogDetailScreen
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Blog Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Blog Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Poppins",
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Blog Description (Preview)
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: "Poppins",
                      color: Colors.grey[800],
                    ),
                    maxLines: 3, // Limit to 3 lines for better UI
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Like Button
                  ElevatedButton.icon(
                    onPressed: onLikePressed,
                    icon: const Icon(Icons.thumb_up, color: Colors.white),
                    label: const Text(
                      'Like',
                      style: TextStyle(fontFamily: "Poppins", color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  // Share Button
                  ElevatedButton.icon(
                    onPressed: onSharePressed,
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text(
                      'Share',
                      style: TextStyle(fontFamily: "Poppins", color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
