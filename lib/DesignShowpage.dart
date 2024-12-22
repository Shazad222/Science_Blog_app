import 'package:blog_science_app/models/blog_model.dart';
import 'package:blog_science_app/viewmodels/blog_view_model.dart';
import 'package:blog_science_app/views/showcase_card.dart';
import 'package:flutter/material.dart';

class DesignShowcasePage extends StatefulWidget {
  const DesignShowcasePage({super.key});

  @override
  State<DesignShowcasePage> createState() => _DesignShowcasePageState();
}

class _DesignShowcasePageState extends State<DesignShowcasePage> {
  final BlogViewModel viewModel = BlogViewModel();
  List<Blog> blogs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedBlogs = await viewModel.fetchBlogs();
      setState(() {
        blogs = fetchedBlogs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching blogs: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Showcase'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : blogs.isEmpty
              ? const Center(child: Text("No blogs available"))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome to the Showcase",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 4 / 4,
                          ),
                          itemCount: blogs.length,
                          itemBuilder: (context, index) {
                            final blog = blogs[index];
                            return ShowcaseCard(
                              title: blog.title,
                              imageUrl: blog.imageUrl,
                              description: blog.content,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
