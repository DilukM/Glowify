import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/view/login/login_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  // User profile data - in a real app, this would come from an auth service
  final Map<String, dynamic> _userData = {
    'name': 'Sarah Johnson',
    'email': 'sarah.j@example.com',
    'phone': '+1 (555) 123-4567',
    'skinType': 'Combination',
    'concerns': ['Acne', 'Hyperpigmentation'],
    'memberSince': 'April 2025',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Top Logo and Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Tcolor.primary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Tcolor.primary,
                    onPressed: () {
                      _showSettingsDialog(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // User profile image with edit button
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Tcolor.textfield,
                  child:
                      Icon(Icons.person, size: 60, color: Tcolor.placeholder),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Show image picker options
                      _showImagePickerOptions();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Tcolor.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // User name
            Text(
              _userData['name'],
              style: TextStyle(
                color: Tcolor.primaryText,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 5),

            // User email
            Text(
              _userData['email'],
              style: TextStyle(
                color: Tcolor.secondaryText,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 5),

            // Member since
            Text(
              "Member since ${_userData['memberSince']}",
              style: TextStyle(
                color: Tcolor.placeholder,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 30),

            // Profile stats
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Tcolor.card,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("Skin Type", _userData['skinType']),
                  Container(
                    height: 50,
                    width: 1,
                    color: Tcolor.placeholder.withOpacity(0.3),
                  ),
                  _buildStatItem(
                    "Skin Concerns",
                    _userData['concerns'].join(', '),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Account options
            _buildAccountOption(Icons.person, "Edit Profile", () {
              _showEditProfileDialog(context);
            }),
            _buildAccountOption(Icons.history, "History", () {
              _showFeatureComingSoonMessage(context, "History");
            }),
            _buildAccountOption(Icons.help_outline, "Help & Support", () {
              _showFeatureComingSoonMessage(context, "Help & Support");
            }),
            _buildAccountOption(Icons.info_outline, "About", () {
              _showFeatureComingSoonMessage(context, "About");
            }),
            _buildAccountOption(Icons.logout, "Logout", () {
              _showLogoutConfirmation(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Tcolor.secondaryText,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Tcolor.primaryText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildAccountOption(
      IconData icon, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Tcolor.card,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Tcolor.primary,
                size: 24,
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  color: Tcolor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Tcolor.placeholder,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Tcolor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Change Profile Photo",
                style: TextStyle(
                  color: Tcolor.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              _buildOptionTile(Icons.camera_alt, "Take a Photo", () {
                Navigator.pop(context);
                // TODO: Implement camera functionality
              }),
              const SizedBox(height: 15),
              _buildOptionTile(Icons.photo_library, "Choose from Gallery", () {
                Navigator.pop(context);
                // TODO: Implement gallery pick functionality
              }),
              const SizedBox(height: 15),
              _buildOptionTile(Icons.delete, "Remove Current Photo", () {
                Navigator.pop(context);
                // TODO: Implement remove photo functionality
              }),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Tcolor.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Tcolor.primary),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: Tcolor.primaryText,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    // This would navigate to a proper edit profile screen in a real app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Edit Profile feature coming soon!",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Tcolor.primary,
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    // This would navigate to a settings screen in a real app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Settings feature coming soon!",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Tcolor.primary,
      ),
    );
  }

  void _showFeatureComingSoonMessage(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$feature feature coming soon!",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Tcolor.primary,
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout",
            style: TextStyle(
              color: Tcolor.primaryText,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Tcolor.secondaryText,
              fontFamily: 'Poppins',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Tcolor.primaryText,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Tcolor.primary,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
