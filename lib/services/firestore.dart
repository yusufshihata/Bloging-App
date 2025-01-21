import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBlog(
      String? title, String? subtitle, String? description, String? content) async {
    try {
      print("Adding blog: $title, $subtitle, $description, $content");
      // Create a blog data map
      Map<String, dynamic> blogData = {
        'title': title ?? 'No Title',
        'subtitle': subtitle ?? 'No Subtitle',
        'description': description ?? 'No Description',
        'content': content ?? 'No Content',
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Add the blog to Firestore
      await _firestore.collection('blogs').add(blogData);

      print("Blog added successfully!");
    } catch (e) {
      print("Failed to add blog: $e");
      throw e;
    }
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
      throw e;
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
      throw e;
    }
  }
}
