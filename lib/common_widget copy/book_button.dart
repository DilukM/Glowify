// Define the SalonBookingView class
import 'package:flutter/material.dart';

class SalonBookingView extends StatelessWidget {
  const SalonBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salon Booking"),
      ),
      body: const Center(
        child: Text("Salon Booking View Content"),
      ),
    );
  }
}
