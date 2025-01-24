import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String content;
  final String authorName;
  final DateTime timestamp;

  Blog({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.content,
    required this.authorName,
    required this.timestamp,
  });

  factory Blog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Blog(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      description: data['description'] ?? '',
      content: data['content'] ?? '',
      authorName: data['authorName'] ?? 'Unknown',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
