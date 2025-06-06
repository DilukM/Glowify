import 'dart:io';
import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/view/chat/chat_screen.dart';
import 'package:research_proj/view/home/AnalysisResultPage.dart';
import 'package:research_proj/view/home/AppointmentView.dart';
import 'package:research_proj/view/home/TipsView.dart';
import 'package:research_proj/view/home/UploadeImageView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Top Logo and Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'glowify',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Tcolor.primary,
                      fontFamily: 'Prata',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Tcolor.primary,
                    onPressed: () {
                      // Navigate to the chat view
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Image Placeholder (Default Avatar)
            CircleAvatar(
              radius: 60,
              backgroundColor: Tcolor.textfield,
              child: Icon(Icons.person, size: 50, color: Tcolor.placeholder),
            ),

            const SizedBox(height: 30),

            // Upload Image Avatar (navigate to UploadImageView)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadImageView(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Tcolor.textfield,
                backgroundImage:
                    _selectedImage != null ? FileImage(_selectedImage!) : null,
                child: _selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Tcolor.primary,
                            size: 30,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "UPLOAD IMAGE",
                            style: TextStyle(
                              color: Tcolor.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 8,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 50),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  buildButton(
                    "ANALYZE",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AnalysisResultPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  buildButton(
                    "APPOINTMENTS",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppointmentView(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  buildButton(
                    "Tips & Suggestions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TipsView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: Tcolor.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Tcolor.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
