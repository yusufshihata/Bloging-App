import 'package:flutter/material.dart';
import 'package:blogly/screens/login.dart';
import 'package:blogly/screens/signup.dart';
import './create_blog.dart';
import '../widgets/cards_list.dart'; // Ensure CardList is designed for production
import '../models/blog.dart';
import '../services/firestore.dart'; // Import FirestoreService
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateBlog(
                    reloadBlogs: _loadBlogs, // Reload blogs when returning
                  ),
                ),
              );
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
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            accountName: const Text(
              "Yusuf Shihata",
              style: TextStyle(fontFamily: "Poppins", fontSize: 16),
            ),
            accountEmail: const Text(
              "yusufshihata2006@gmail.com",
              style: TextStyle(fontFamily: "Poppins", fontSize: 14),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "YS",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
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
      ),
    );
  }
}
