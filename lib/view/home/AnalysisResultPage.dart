import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/view/home/HomeView.dart';

class AnalysisResultPage extends StatelessWidget {
  const AnalysisResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                    },
                    child: Text(
                      'glowify',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Tcolor.primary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Icon(Icons.send, color: Tcolor.primary),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              "RESULTS",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Tcolor.primary,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 20),

            // Main Face Image with Indicators
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/img/face_result.png', width: 250),
                // Overlay result marks (optional if static)
              ],
            ),

            const SizedBox(height: 24),

            // Score Cards Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildResultCard("80%", "Skin Type", "Dry skin"),
                  _buildResultCard("60%", "Forehead", "Red spots observed"),
                  _buildResultCard(
                    "40%",
                    "Jawline",
                    "Dryness and redness detected",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Overall condition
            Text(
              "Overall Condition",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Tcolor.secondaryText,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Signs of irritation and dryness across key areas",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Tcolor.secondaryText,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 30),

            // Re-check button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // or re-analyze logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Tcolor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              child: Text(
                "RE-CHECK",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String percentage, String title, String subtitle) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Tcolor.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            percentage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
