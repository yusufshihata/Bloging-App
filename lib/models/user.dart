import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String password;

  User({required this.uid, required this.name, required this.email, required this.password});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> user = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      name: user['name'],
      email: user['email'],
      password: user['password'],
    );
  }
}