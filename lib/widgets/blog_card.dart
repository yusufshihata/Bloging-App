import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  final VoidCallback onLikePressed;
  final VoidCallback onSharePressed;

  const BlogCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.onLikePressed,
    required this.onSharePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blog Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                // Subtitle
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.0),
                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16.0),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Like Button
                    ElevatedButton.icon(
                      onPressed: onLikePressed,
                      icon: Icon(Icons.thumb_up, color: Colors.white),
                      label: Text('Like', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    // Share Button
                    ElevatedButton.icon(
                      onPressed: onSharePressed,
                      icon: Icon(Icons.share, color: Colors.white,),
                      label: Text('Share', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}