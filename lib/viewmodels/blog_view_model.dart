import 'dart:convert';

import 'package:blog_science_app/models/blog_model.dart';
import 'package:http/http.dart' as http;

import '../services/cloudinary_service.dart';

class BlogViewModel {
  final String apiUrl = "https://science-blog-app.onrender.com/api/blogs";
  final CloudinaryService _cloudinaryService = CloudinaryService();
  // Fetching all Blogs
  Future<List<Blog>> fetchBlogs() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Blog.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load blogs");
    }
  }

// Save a new Blog
  Future<void> saveBlog(
      String title, String content, List<int> imageBytes) async {
    final imageUrl =
        await _cloudinaryService.uploadImage(imageBytes, "pickedImage");
    final blog = Blog(
      id: "",
      title: title,
      content: content,
      imageUrl: imageUrl,
    );
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(blog.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Faild to save blog");
    }
  }
}
