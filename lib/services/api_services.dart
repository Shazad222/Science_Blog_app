import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  // final String apiUrl = "http://localhost:5000/api/blogs";

  final String apiUrl = "https://science-blog-app.onrender.com/api/blogs";

  Future<List<dynamic>> fetchBlogs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Faild to load blogs");
    }
  }
}
