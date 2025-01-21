import 'package:blogly/screens/login.dart';
import 'package:flutter/material.dart';
import '../widgets/cards_list.dart'; // Make sure this widget can accept the list of blogs
import '../models/blog.dart';
import 'package:blogly/screens/signup.dart';
import './create_blog.dart';
import '../services/firestore.dart'; // Import FirestoreService

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();

  late Future<List<Blog>> _blogs; // Declare a Future to hold the list of blogs

  @override
  void initState() {
    super.initState();
    _blogs = firestoreService.getBlogs(); // Fetch blogs when the screen is initialized
  }

  // Function to reload blogs after a new one is added
  void _reloadBlogs() {
    setState(() {
      _blogs = firestoreService.getBlogs(); // Fetch the updated list of blogs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BlogLy",
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.2,
        actions: [
          IconButton(
            color: Colors.lightBlueAccent,
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create a new blog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateBlog(
                    reloadBlogs: _reloadBlogs, // Pass the reloadBlogs function
                  ),
                ),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
              accountName: Text("Yusuf Shihata", style: TextStyle(fontFamily: "Poppins")),
              accountEmail: Text("yusufshihata2006@gmail.com", style: TextStyle(fontFamily: "Poppins")),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: Text(
                    "YS",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text("Sign In", style: TextStyle(fontFamily: "Poppins")),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
            ListTile(
              title: Text("Sign up", style: TextStyle(fontFamily: "Poppins")),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (content) => const Signup()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Blog>>(
          future: _blogs, // The future that fetches the blogs
          builder: (context, snapshot) {
            // Check the connection state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Check for errors
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            // If data is available
            if (snapshot.hasData) {
              List<Blog> blogs = snapshot.data!;
              return CardList(
                blogs: blogs, // Pass the blogs to the CardList widget
              );
            }

            // In case no data is available
            return Center(child: Text("No blogs available"));
          },
        ),
      ),
    );
  }
}
