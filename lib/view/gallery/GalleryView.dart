import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  // Mock data for gallery images
  final List<Map<String, dynamic>> _galleryItems = [
    {
      'image': 'assets/img/face_result.png',
      'date': 'June 2, 2025',
      'title': 'First Analysis'
    },
    {
      'image': 'assets/img/img1.png',
      'date': 'May 29, 2025',
      'title': 'Dermatitis Check'
    },
    {
      'image': 'assets/img/img2.png',
      'date': 'May 25, 2025',
      'title': 'Acne Progress'
    },
    {
      'image': 'assets/img/img3.png',
      'date': 'May 20, 2025',
      'title': 'Weekly Check'
    },
    {
      'image': 'assets/img/img4.png',
      'date': 'May 15, 2025',
      'title': 'Treatment Progress'
    },
    {
      'image': 'assets/img/img5.png',
      'date': 'May 10, 2025',
      'title': 'Baseline Scan'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Top Logo and Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Tcolor.primary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.filter_list),
                      color: Tcolor.primary,
                      onPressed: () {}),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Gallery content
            _galleryItems.isEmpty
                ? _buildEmptyState()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _galleryItems.length,
                        itemBuilder: (context, index) {
                          return _buildGalleryItem(_galleryItems[index]);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Tcolor.primary,
        onPressed: () {
          // Action to add new image
          _showAddPhotoOptions();
        },
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library,
              size: 100,
              color: Tcolor.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 20),
            Text(
              "Your Photo Gallery",
              style: TextStyle(
                color: Tcolor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your skin analysis photos will appear here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Tcolor.secondaryText,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        // Navigate to detailed view
        _showImageDetails(item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Tcolor.card,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.asset(
                  item['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      color: Tcolor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['date'],
                    style: TextStyle(
                      color: Tcolor.secondaryText,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPhotoOptions() {
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
                "Add Photo",
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

  void _showImageDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(imageData: item),
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final Map<String, dynamic> imageData;

  const ImageDetailScreen({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      appBar: AppBar(
        backgroundColor: Tcolor.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Tcolor.primary),
        title: Text(
          imageData['title'],
          style: TextStyle(
            color: Tcolor.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Image.asset(
            imageData['image'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageData['title'],
                  style: TextStyle(
                    color: Tcolor.primaryText,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  imageData['date'],
                  style: TextStyle(
                    color: Tcolor.secondaryText,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Analysis Results",
                  style: TextStyle(
                    color: Tcolor.primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                _buildResultItem("Skin Type", "Combination"),
                _buildResultItem("Hydration", "Good (75%)"),
                _buildResultItem("Concerns", "Minor acne, Some dryness"),
                _buildResultItem("Recommendations",
                    "Increase moisturizer use, Gentle exfoliation"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              color: Tcolor.primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Tcolor.secondaryText,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
