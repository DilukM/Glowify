 import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/view/home/HomeView.dart';


import 'package:flutter/material.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips & Suggestions'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Here are some tips and suggestions!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();

  String _response = '';

  @override
  void initState() {
    super.initState();

  }

  void _handleSubmit() {
    final input = _controller.text.trim();
    if (input.isEmpty) return;


    // Sample response mapping (replace with real ones)
    final responses = {
      "dry_skin": "Make sure to use a gentle moisturizer daily.",
      "oily_skin": "Use oil-free products and cleanse twice a day.",
      "sensitive_skin": "Avoid fragranced products and patch-test new items.",
    };

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "TIPS & SUGGESTIONS",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[700],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "COMMON TIPS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTip(
                    "Take the photo in a well-lit environment to avoid shadows or overexposure.",
                  ),
                  _buildTip(
                    "Ensure your face is fully visible and not covered by accessories like sunglasses or hats.",
                  ),
                  _buildTip("Use a plain background to minimize distractions."),
                  _buildTip(
                    "Avoid using filters or effects that alter the natural appearance of your skin.",
                  ),
                  _buildTip(
                    "Take the photo directly from the front, ensuring your face is centered.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "ASK ANYTHING...?",
              style: TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange[800]!),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type here...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('SUBMIT'),
            ),
            if (_response.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _response,
                  style: TextStyle(color: Colors.brown[800], fontSize: 14),
                ),
              ),
            const Spacer(),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "• $tip",
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "FAVOURITES",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            label: "GALLERY",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "ACCOUNT",
          ),
        ],
      ),
    );
  }
}

