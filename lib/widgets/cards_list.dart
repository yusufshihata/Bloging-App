import 'package:flutter/material.dart';
import '../models/blog.dart';
import './blog_card.dart';


class CardList extends StatelessWidget {
  final List<Blog> blogs;

  const CardList({required this.blogs, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: BlogCard(
            imageUrl: blog.imageUrl,
            title: blog.title,
            subtitle: blog.subtitle,
            description: blog.description,
            onLikePressed: () {
              print('Liked ${blog.title}');
            },
            onSharePressed: () {
              print('Shared ${blog.title}');
            },
          ),
        );
      },
    );
  }
}
