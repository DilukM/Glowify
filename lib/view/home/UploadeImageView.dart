import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/view/home/HomeView.dart';

class UploadImageView extends StatefulWidget {
  const UploadImageView({Key? key}) : super(key: key);

  @override
  State<UploadImageView> createState() => _UploadImageViewState();
}

class _UploadImageViewState extends State<UploadImageView> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _openCameraOnStart(); // Automatically open the camera when the page loads
  }

  Future<void> _openCameraOnStart() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Short delay to avoid UI blocking
    _pickImage(); // Open camera
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera, // ✅ Use camera instead of gallery
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Logo
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
              child: Text(
                "glowify",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Tcolor.primary,
                  fontFamily: 'Prata',
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Image display area
            GestureDetector(
              onTap: _pickImage, // Taps allow user to re-take photo
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Tcolor.textfield,
                backgroundImage:
                    _selectedImage != null ? FileImage(_selectedImage!) : null,
                child:
                    _selectedImage == null
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Tcolor.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "CAPTURE IMAGE",
                              style: TextStyle(
                                color: Tcolor.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        )
                        : null,
              ),
            ),

            const SizedBox(height: 30),

            // Instructions
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Tcolor.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "INSTRUCTIONS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildBullet(
                    "Take the photo in a well-lit environment to avoid shadows.",
                  ),
                  _buildBullet(
                    "Make sure your face is clearly visible without accessories.",
                  ),
                  _buildBullet("Use a plain background for better analysis."),
                  _buildBullet("Avoid using filters that change skin tone."),
                  _buildBullet(
                    "Face the camera directly and keep it centered.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.white, fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
