import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/common_widget%20copy/round_button.dart';
import 'package:research_proj/common_widget%20copy/round_textfield.dart';
import 'package:research_proj/common_widget/round_button.dart';
import 'package:research_proj/common_widget/round_textfield.dart';
import 'package:research_proj/view/login/login_view.dart';
import 'package:research_proj/view/main_tabview/MainTabView.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

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
              const SizedBox(height: 80), // Adjusted variable name
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Tcolor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                "Create your account to unlock personalized skincare insights ",
                style: TextStyle(
                  color: Tcolor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),

              RoundTextField(
                hintText: "Name",
                controller: txtName,
                obscureText: false,
              ),
              const SizedBox(height: 25),

              RoundTextField(
                hintText: "Email",
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),

              const SizedBox(height: 25),

              RoundTextField(
                hintText: "Contact No",
                controller: txtMobile,
                obscureText: false,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 25),

              RoundTextField(
                hintText: "Address",
                controller: txtAddress,
                obscureText: false,
              ),
              const SizedBox(height: 20),

              RoundTextField(
                hintText: "Password",
                controller: txtPassword,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              RoundTextField(
                hintText: "Confirm Password",
                controller: txtPassword,
                obscureText: true,
              ),
              const SizedBox(height: 25),

              RoundButton(
                  Title: "Sign up",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainTabView()),
                    );
                  }),

              const SizedBox(height: 50),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have  an account? ",
                      style: TextStyle(
                        color: Tcolor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Login",
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
