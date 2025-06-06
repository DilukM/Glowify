import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/common_widget%20copy/round_button.dart';
import 'package:research_proj/view/chat/chat_screen.dart';
import 'package:research_proj/view/login/login_view.dart';
import 'package:research_proj/view/login/sign_up_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common_widget/round_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/img/LOGO.png",
              width:
                  mediaQuery.width * 0.3, // Adjusted to make the image smaller
              height:
                  mediaQuery.height * 0.2, // Adjusted to make the image smaller
              fit: BoxFit
                  .contain, // Ensures the image maintains its aspect ratio
            ),
          ),
          Text(
            "Welcome to GLOWIFY",
            style: TextStyle(
              color: Tcolor.primaryText,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 25), // Adjusted variable name

          Text(
            "Glowing skin isn’t a dream it’s a journey.\nLet’s begin with personalized insights \nand real results.\n", // Replaced 'Title' with a valid string
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Tcolor.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 30),
          // Adjusted variable name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RoundButton(
              Title: "Login",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RoundButton(
              Title: "Create an Account",
              type: RoundButtonType.textPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpView()),
                );
              },
            ),
          ), // Adjusted variable name

         
        ],
      ),
    );
  }
}
