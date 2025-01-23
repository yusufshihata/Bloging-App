import 'package:flutter/material.dart';
import '../models/blog.dart';
import './blog_card.dart';

class CardList extends StatelessWidget {
  final List<Blog> blogs;

  const CardList({
    required this.blogs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return blogs.isEmpty
        ? Center(
      child: Text(
        "No blogs available",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey[600],
          fontFamily: "Poppins",
        ),
      ),
    )
        : ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: blogs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return BlogCard(
          id: blog.id,
          title: blog.title,
          subtitle: blog.subtitle,
          description: blog.description,
          onLikePressed: () {
            debugPrint('Liked blog: ${blog.title}');
            // Add real like functionality here
          },
          onSharePressed: () {
            debugPrint('Shared blog: ${blog.title}');
            // Add real share functionality here
          },
        );
      },
    );
  }
}

