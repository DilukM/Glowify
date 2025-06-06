import 'package:research_proj/view/login/welcome_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        MaterialPageRoute,
        Placeholder,
        Scaffold,
        State,
        StatefulWidget,
        Widget;

class Startupview extends StatefulWidget {
  const Startupview({super.key});

  // Named constructor
  const Startupview.custom({super.key});

  @override
  State<Startupview> createState() => _StartupviewState();
}

class _StartupviewState extends State<Startupview> {
  @override
  void initState() {
    super.initState();
    goWelcomePage();
  }

  void goWelcomePage() async {
    await Future.delayed(const Duration(seconds: 2));
    welcomePage();
  }

  void welcomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        // Ensures the image is centered
        child: Image.asset(
          "assets/img/LOGO.png",
          width: mediaQuery.width * 0.4, // Adjusted to make the image smaller
          height: mediaQuery.height * 0.4, // Adjusted to make the image smaller
          fit: BoxFit.contain, // Ensures the image maintains its aspect ratio
        ),
      ),
    );
  }
}
