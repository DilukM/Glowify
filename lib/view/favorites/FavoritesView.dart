import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for favorites
  final List<Map<String, dynamic>> _favoriteProducts = [
    {
      'name': 'Hydrating Facial Cleanser',
      'brand': 'CeraVe',
      'image': 'assets/img/img1.png',
      'rating': 4.8,
      'isFavorite': true,
    },
    {
      'name': 'Vitamin C Serum',
      'brand': 'Timeless',
      'image': 'assets/img/img2.png',
      'rating': 4.7,
      'isFavorite': true,
    },
    {
      'name': 'Moisturizing Cream',
      'brand': 'La Roche-Posay',
      'image': 'assets/img/img3.png',
      'rating': 4.9,
      'isFavorite': true,
    },
  ];

  final List<Map<String, dynamic>> _favoriteTips = [
    {
      'title': 'How to Layer Skincare Products',
      'author': 'Dr. Smith',
      'image': 'assets/img/img4.png',
      'date': 'June 1, 2025',
      'isFavorite': true,
    },
    {
      'title': 'Best Ingredients for Acne-Prone Skin',
      'author': 'Skincare Expert',
      'image': 'assets/img/img5.png',
      'date': 'May 28, 2025',
      'isFavorite': true,
    },
    {
      'title': 'Understanding Your Skin Barrier',
      'author': 'Dermatology Journal',
      'image': 'assets/img/img1.png',
      'date': 'May 25, 2025',
      'isFavorite': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                    'Favorites',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Tcolor.primary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.notifications_none),
                      color: Tcolor.primary,
                      onPressed: () {}),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Tcolor.card,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Tcolor.primary,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Tcolor.primaryText,
                labelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: "Products"),
                  Tab(text: "Tips & Articles"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Products Tab
                  _favoriteProducts.isEmpty
                      ? _buildEmptyState("No Favorite Products",
                          "Products you favorite will appear here")
                      : _buildProductsList(),

                  // Tips Tab
                  _favoriteTips.isEmpty
                      ? _buildEmptyState("No Favorite Tips",
                          "Tips and articles you favorite will appear here")
                      : _buildTipsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 100,
            color: Tcolor.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            title,
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
              message,
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
    );
  }

  Widget _buildProductsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _favoriteProducts.length,
      itemBuilder: (context, index) {
        final product = _favoriteProducts[index];
        return _buildProductItem(product);
      },
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.asset(
              product['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      color: Tcolor.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product['brand'],
                    style: TextStyle(
                      color: Tcolor.secondaryText,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${product['rating']}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Favorite Button
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Tcolor.primary,
              ),
              onPressed: () {
                // Toggle favorite status
                setState(() {
                  product['isFavorite'] = !product['isFavorite'];
                  if (!product['isFavorite']) {
                    _favoriteProducts.remove(product);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _favoriteTips.length,
      itemBuilder: (context, index) {
        final tip = _favoriteTips[index];
        return _buildTipItem(tip);
      },
    );
  }

  Widget _buildTipItem(Map<String, dynamic> tip) {
    return GestureDetector(
      onTap: () {
        // Navigate to tip detail screen
        _showTipDetails(tip);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
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
            // Tip Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                tip['image'],
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Tip Details
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          tip['title'],
                          style: TextStyle(
                            color: Tcolor.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Tcolor.primary,
                        ),
                        onPressed: () {
                          // Toggle favorite status
                          setState(() {
                            tip['isFavorite'] = !tip['isFavorite'];
                            if (!tip['isFavorite']) {
                              _favoriteTips.remove(tip);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "By ",
                        style: TextStyle(
                          color: Tcolor.secondaryText,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        tip['author'],
                        style: TextStyle(
                          color: Tcolor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        tip['date'],
                        style: TextStyle(
                          color: Tcolor.secondaryText,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTipDetails(Map<String, dynamic> tip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TipDetailScreen(tipData: tip),
      ),
    );
  }
}

class TipDetailScreen extends StatelessWidget {
  final Map<String, dynamic> tipData;

  const TipDetailScreen({super.key, required this.tipData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.white,
      appBar: AppBar(
        backgroundColor: Tcolor.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Tcolor.primary),
        title: Text(
          "Article",
          style: TextStyle(
            color: Tcolor.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Tcolor.primary),
            onPressed: () {
              // Toggle favorite
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            Image.asset(
              tipData['image'],
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    tipData['title'],
                    style: TextStyle(
                      color: Tcolor.primaryText,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Author and Date
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Tcolor.primary,
                        child: Text(
                          tipData['author'].substring(0, 1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        tipData['author'],
                        style: TextStyle(
                          color: Tcolor.primaryText,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        tipData['date'],
                        style: TextStyle(
                          color: Tcolor.secondaryText,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Article Content - Mock content
                  _buildParagraph(
                    "Introduction",
                    "Understanding your skincare needs is essential for maintaining healthy, glowing skin. This article explores the fundamentals of proper skincare routines and ingredients that work best for different skin types.",
                  ),
                  _buildParagraph(
                    "Key Points",
                    "• Always cleanse your skin morning and night\n• Apply products from thinnest to thickest consistency\n• Use sunscreen daily, even on cloudy days\n• Pay attention to how your skin reacts to products\n• Consistency is key for seeing results",
                  ),
                  _buildParagraph(
                    "Recommended Steps",
                    "1. Cleanser: Remove dirt, oil, and makeup\n2. Toner: Balance skin pH levels\n3. Serum: Target specific skin concerns\n4. Moisturizer: Hydrate and protect\n5. Sunscreen: Shield from UV damage",
                  ),
                  _buildParagraph(
                    "Conclusion",
                    "The best skincare routine is one that works for your specific skin type and concerns. Don't be afraid to experiment with different products, but introduce them gradually and pay attention to how your skin responds. Remember that skincare is a marathon, not a sprint—consistency over time will yield the best results.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParagraph(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Tcolor.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              color: Tcolor.secondaryText,
              fontSize: 16,
              height: 1.5,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
