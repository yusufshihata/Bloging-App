import 'package:flutter/material.dart';
import '../widgets/blog_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlogLy"),
        elevation: 0.2,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Yusuf Shihata"),
              accountEmail: Text("yusufshihata2006@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  child: Text(
                    "YS",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text("Your Blogs"),
            ),
            ListTile(
              title: Text("Saved Blogs"),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          BlogCard(
            imageUrl: 'https://picsum.photos/250?image=9',
            title: "My First Blog",
            subtitle: "This is my first blog on this app",
            description: "This is a blog that i can test the card widget on.",
            onLikePressed: () { print("Hello, Like"); },
            onSharePressed: () { print("Hello, Share"); },
          ),
        ],
      )
    );
  }
}
