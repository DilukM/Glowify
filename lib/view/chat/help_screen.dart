import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About This Chatbot'),
        backgroundColor: Tcolor.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Skincare Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Tcolor.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This chatbot is trained to help with various skincare concerns. It can provide advice, tips, and information on:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildFeatureList(),
            const SizedBox(height: 24),
            Text(
              'Privacy Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Tcolor.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This app runs completely offline. Your conversations and queries are processed locally on your device and are not sent to any external servers.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Limitations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Tcolor.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This chatbot provides general skincare advice. It is not intended to replace professional medical advice. For serious skin conditions, please consult a dermatologist or healthcare professional.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Tcolor.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Return to Chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      'Dry skin treatments',
      'Oily skin care',
      'Acne treatments',
      'Anti-aging advice',
      'Product recommendations',
      'Skincare routines',
      'Sun protection',
      'Sensitive skin care',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Tcolor.primary, size: 18),
                  const SizedBox(width: 8),
                  Text(feature, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
