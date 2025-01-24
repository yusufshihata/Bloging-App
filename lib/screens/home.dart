import 'package:blogly/services/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:blogly/screens/login.dart';
import 'package:blogly/screens/signup.dart';
import './create_blog.dart';
import '../widgets/cards_list.dart';
import '../models/blog.dart';
import '../services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/profileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirestoreService firestoreService = FirestoreService();

  late Future<List<Blog>> _blogs;

  @override
  void initState() {
    super.initState();
    _loadBlogs();
  }

  void _loadBlogs() {
    setState(() {
      _blogs = firestoreService.getBlogs(); // Fetch the blogs
    });
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No user logged in.');
      }

      // Fetch user data from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BlogLy",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add New Blog",
            onPressed: () {
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateBlog(
                      reloadBlogs: _loadBlogs, // Reload blogs when returning
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You must be signed in to create a blog."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Blog>>(
          future: _blogs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading blogs: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return CardList(blogs: snapshot.data!);
            }

            return const Center(
              child: Text(
                "No blogs available. Start by adding one!",
                style: TextStyle(fontFamily: "Poppins", fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildDrawer(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: currentUser == null
          ? ListView(
              children: [
                const UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  accountName: Text(
                    "Guest",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                  ),
                  accountEmail: Text(
                    "Sign in to access your account",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.login, color: Colors.blueAccent),
                  title: const Text(
                    "Sign In",
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add, color: Colors.blueAccent),
                  title: const Text(
                    "Sign Up",
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                ),
              ],
            )
          : FutureBuilder<Map<String, dynamic>?>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return ListView(
                    children: [
                      const UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.blueAccent),
                        accountName: Text("Error loading user data"),
                        accountEmail: Text("Please check your internet connection"),
                      ),
                    ],
                  );
                }

                final userData = snapshot.data!;

                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Colors.blueAccent),
                      accountName: Text(
                        userData['displayName'] ?? "User",
                        style: const TextStyle(fontFamily: "Poppins", fontSize: 16),
                      ),
                      accountEmail: Text(
                        userData['email'] ?? "No email",
                        style: const TextStyle(fontFamily: "Poppins", fontSize: 14),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          (userData['displayName'] ?? "U")
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.blueAccent),
                      title: const Text(
                        "Account Info",
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.blueAccent),
                      title: const Text(
                        "Logout",
                        style: TextStyle(fontFamily: "Poppins"),
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {}); // Trigger rebuild after sign-out
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }


}

