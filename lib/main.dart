import 'package:blog_science_app/DesignShowpage.dart';
import 'package:blog_science_app/views/blog_create_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BlogCreatePage(),
    );
  }
}
