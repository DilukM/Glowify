import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/common_widget%20copy/round_button.dart';
import 'package:research_proj/common_widget%20copy/round_textfield.dart';
import 'package:research_proj/common_widget/round_button.dart';
import 'package:research_proj/common_widget/round_textfield.dart';
import 'package:research_proj/view/login/sign_up_view.dart';
import 'package:research_proj/view/main_tabview/MainTabView.dart';
import 'package:flutter/material.dart';
// Import the SignUpView class

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150), // Adjusted variable name
              Text(
                "Login",
                style: TextStyle(
                  color: Tcolor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Add your details to Login",
                style: TextStyle(
                  color: Tcolor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),

              RoundTextField(
                hintText: "Your Email",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
              const SizedBox(height: 20),

              RoundTextField(
                hintText: "Password",
                controller: txtPassword,
                obscureText: true,
              ),
              const SizedBox(height: 25),

              RoundButton(
                Title: "Login",
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainTabView()),
                  );
                },
              ),

              const SizedBox(height: 250),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpView()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      " Don't have an account? ",
                      style: TextStyle(
                        color: Tcolor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                        color: Tcolor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
