import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/blog.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBlog({
    required String? title,
    required String? subtitle,
    required String? description,
    required String? content,
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    final blog = {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('blogs').add(blog);
  }


  Future<List<Blog>> getBlogs() async {
    try {
      // Get all blogs from Firestore
      QuerySnapshot snapshot = await _firestore.collection('blogs').orderBy('timestamp', descending: true).get();

      // Map each document to a Blog model
      List<Blog> blogs = snapshot.docs.map((doc) => Blog.fromFirestore(doc)).toList();

      return blogs;
    } catch (e) {
      print("Failed to fetch blogs: $e");
      rethrow;
    }
  }

  Future<Blog?> getBlog(String blogId) async {
    try {
      final docSnapshot = await _firestore.collection('blogs').doc(blogId).get();

      if (docSnapshot.exists) {
        return Blog.fromFirestore(docSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching blog by ID: $e");
      rethrow;
    }
  }
}
