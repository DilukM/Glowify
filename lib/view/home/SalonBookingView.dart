import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/view/home/HomeView.dart'; // adjust path as needed
//  Update this path if needed

class SalonBookingView extends StatefulWidget {
  const SalonBookingView({super.key});

  @override
  State<SalonBookingView> createState() => _SalonBookingViewState();
}

class _SalonBookingViewState extends State<SalonBookingView> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // glowify header with navigation
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
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
                          fontFamily: 'Prata',
                        ),
                      ),
                    ),
                    Icon(Icons.send, color: Tcolor.primary),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  "SALOON ROO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Tcolor.secondaryText,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Service cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildServiceCard("80%", "Clean", "Clean up"),
                  buildServiceCard("60%", "Glow look", "Facial"),
                  buildServiceCard("40%", "Sharpness", "Threading"),
                ],
              ),

              const SizedBox(height: 30),

              Text(
                "Schedule your Appointment",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Tcolor.primaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Book a convenient time for your salon visit directly through the app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Tcolor.secondaryText,
                ),
              ),
              const SizedBox(height: 20),

              buildInputField("Name", _nameController),
              const SizedBox(height: 15),
              buildInputField("Date", _dateController),
              const SizedBox(height: 15),
              buildInputField("Time", _timeController),
              const SizedBox(height: 15),
              buildInputField("Contact Number", _contactController),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  print("Booking Submitted");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Appointment Booked!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Tcolor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "BOOK",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildServiceCard(String percent, String label, String title) {
    return Column(
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Tcolor.primary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Text(
                percent,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Tcolor.primaryText,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: TextStyle(color: Tcolor.primaryText),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
