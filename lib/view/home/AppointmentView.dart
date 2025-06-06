import 'package:flutter/material.dart';
import 'package:research_proj/common/color_extension.dart';
import 'package:research_proj/data/salon_data.dart';
import 'package:research_proj/models/salon_model.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  List<SalonModel> salons = [];

  @override
  void initState() {
    super.initState();
    // Get salons from our data source
    salons = SalonData.getSalons();
  }

  @override
  Widget build(BuildContext context) {
    List<SalonModel> featuredSalons =
        salons.where((salon) => salon.isFeatured).toList();
    List<SalonModel> regularSalons =
        salons.where((salon) => !salon.isFeatured).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Text(
                      'glowify',
                      style: TextStyle(
                        fontFamily: 'Prata',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE5A126),
                      ),
                    ),
                    // Notification icon
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Color(0xFFE5A126),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Schedule Appointment title
              Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  'SCHEDULE APPOINTMENT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Tcolor.primary,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Featured section
              Text(
                'Featured',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Tcolor.primary,
                ),
              ),

              const SizedBox(height: 10),

              // Featured salons horizontal list
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredSalons.length,
                  itemBuilder: (context, index) {
                    return FeaturedSalonCard(salon: featuredSalons[index]);
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Regular salons vertical list
              Expanded(
                child: ListView.builder(
                  itemCount: regularSalons.length,
                  itemBuilder: (context, index) {
                    // Alternate layout based on index (even/odd)
                    bool isEven = index % 2 == 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: RegularSalonCard(
                          salon: regularSalons[index], isImageOnRight: isEven),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedSalonCard extends StatelessWidget {
  final SalonModel salon;

  const FeaturedSalonCard({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 24),
      child: Column(
        children: [
          // Salon image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                salon.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Salon name
          Text(
            salon.name,
            style: TextStyle(
              color: Tcolor.primary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class RegularSalonCard extends StatelessWidget {
  final SalonModel salon;
  final bool isImageOnRight;

  const RegularSalonCard({
    Key? key,
    required this.salon,
    this.isImageOnRight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create the info column and image widgets
    Widget infoWidget = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            salon.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Tcolor.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            salon.description,
            style: TextStyle(
              fontSize: 14,
              color: Tcolor.black,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          // Book button
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Tcolor.primary,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'BOOK',
                style: TextStyle(
                  color: Tcolor.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Widget imageWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          salon.imageUrl,
          width: 90,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 90,
              height: 120,
              color: Colors.grey[300],
              child: Icon(Icons.image_not_supported),
            );
          },
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: isImageOnRight
            ? [
                infoWidget,
                const SizedBox(width: 15),
                imageWidget,
              ]
            : [
                imageWidget,
                const SizedBox(width: 15),
                infoWidget,
              ],
      ),
    );
  }
}
