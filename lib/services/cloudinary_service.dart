import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    "dlj48j9ay", // Your Cloudinary cloud name
    "l4pizuwf", // Your Cloudinary upload preset
  );

  /// Upload image to Cloudinary and return the secure URL
  Future<String> uploadImage(List<int> imageBytes, String identifier) async {
    try {
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          imageBytes, // The image as bytes
          identifier:
              identifier, // An identifier for the file (e.g., file name or type)
          folder:
              "categoryImages", // Optional folder in your Cloudinary account
        ),
      );

      return response.secureUrl; // Return the secure URL of the uploaded image
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }
}
