import 'package:blogly/screens/login.dart';
import 'package:flutter/material.dart';
import '../widgets/cards_list.dart';
import '../models/blog.dart';
import 'package:blogly/screens/signup.dart';
import './create_blog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateBlog()),
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
              accountName: Text("Yusuf Shihata", style: TextStyle(fontFamily: "Poppins"),),
              accountEmail: Text("yusufshihata2006@gmail.com", style: TextStyle(fontFamily: "Poppins"),),
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
              title: Text("Sign In", style: TextStyle(fontFamily: "Poppins"),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
            ListTile(
              title: Text("Sign up", style: TextStyle(fontFamily: "Poppins"),),
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
        child: CardList(
              blogs: [
                Blog(
                  imageUrl: 'https://picsum.photos/250?image=9',
                  title: 'Flutter Blog UI',
                  subtitle: 'How to create awesome designs',
                  description: 'Learn the steps to create responsive and attractive UIs in Flutter.',
                  content: "This is the content for Flutter blog",
                ),
                Blog(
                  imageUrl: 'https://picsum.photos/250?image=9',
                  title: 'Dart Language Tips',
                  subtitle: 'Master Dart for Flutter Development',
                  description: 'Explore advanced features of the Dart language and how to use them effectively.',
                  content: "This is the content of the Dart language tips",
                ),
                Blog(
                  imageUrl: 'https://picsum.photos/250?image=9',
                  title: 'State Management in Flutter',
                  subtitle: 'Understand Provider, Riverpod, and more',
                  description: 'Dive deep into the world of state management and pick the right approach for your app.',
                  content: "This is the content of state management in Flutter",
                ),
                Blog(
                  imageUrl: 'https://picsum.photos/250?image=9',
                  title: 'State Management in Flutter',
                  subtitle: 'Understand Provider, Riverpod, and more',
                  description: 'Dive deep into the world of state management and pick the right approach for your app.',
                  content: "This is the content of state management in Flutter",
                ),
              ],
            ),
        ),
    );
  }
}
