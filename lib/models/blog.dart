import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String content;
  final DateTime timestamp;

  Blog({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.content,
    required this.timestamp,
  });

  // Factory method to handle Firestore document conversion
  factory Blog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Blog(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      subtitle: data['subtitle'] ?? 'No Subtitle',
      description: data['description'] ?? 'No Description',
      content: data['content'] ?? 'No Content',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
