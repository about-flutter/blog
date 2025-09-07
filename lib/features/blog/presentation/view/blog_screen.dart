
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              // Use Modular navigation instead of Navigator
              Modular.to.pushNamed('/blog/add');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Modular.to.navigate('/auth/');
            },
          ),
        ],
      ),
    );
  }
}
