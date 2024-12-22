import 'dart:io';

import 'package:blog_science_app/DesignShowpage.dart';
import 'package:blog_science_app/viewmodels/blog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlogCreatePage extends StatefulWidget {
  const BlogCreatePage({super.key});

  @override
  State<BlogCreatePage> createState() => _BlogCreatePageState();
}

class _BlogCreatePageState extends State<BlogCreatePage> {
  final BlogViewModel viewModel = BlogViewModel();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  XFile? pickedImage;
  List<int>? imageBytes;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes =
          await pickedFile.readAsBytes(); // Convert to bytes for Cloudinary
      setState(() {
        pickedImage = pickedFile;
        imageBytes = bytes;
      });
    }
  }

  Future<void> saveBlog() async {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty ||
        imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("ALL Feild are required"),
        ),
      );
      return;
    }
    try {
      await viewModel.saveBlog(
          titleController.text, contentController.text, imageBytes!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Blog saved sucessfully"),
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const DesignShowcasePage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Faild to load ${e}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Blog"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DesignShowcasePage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Title",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Enter the title here here...",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: contentController,
                maxLines: 14,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Content",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Enter the content here...",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text("Pick Image"),
              ),
              const SizedBox(height: 10),
              pickedImage != null
                  ? Image.file(File(pickedImage!.path))
                  : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveBlog,
                child: const Text("Save Blog"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
