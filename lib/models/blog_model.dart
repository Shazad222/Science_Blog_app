class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  // Factory method to create a Blog from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image'],
    );
  }

  // Method to convert Blog to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'image': imageUrl,
    };
  }
}
