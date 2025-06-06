class SalonModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isFeatured;
  final String category;

  SalonModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isFeatured = false,
    this.category = '',
  });

  // Sample data for populating the UI
  static List<SalonModel> getSampleSalons() {
    return [
      // Featured salons
      SalonModel(
        id: '1',
        name: 'Adam & Eve',
        description: 'Premium hair styling and care',
        imageUrl: 'assets/images/salons/adam_eve.jpg',
        isFeatured: true,
        category: 'Hair',
      ),
      SalonModel(
        id: '2',
        name: 'Star Care',
        description: 'Facial and skin treatments',
        imageUrl: 'assets/images/salons/star_care.jpg',
        isFeatured: true,
        category: 'Facial',
      ),
      SalonModel(
        id: '3',
        name: 'Kandy Pearl',
        description: 'Hair coloring and styling experts',
        imageUrl: 'assets/images/salons/kandy_pearl.jpg',
        isFeatured: true,
        category: 'Hair',
      ),
      // Regular salons
      SalonModel(
        id: '4',
        name: 'Saloon Roo',
        description: 'Signs of irritation and dryness across key areas',
        imageUrl: 'assets/images/salons/saloon_roo.jpg',
        category: 'Spa',
      ),
      SalonModel(
        id: '5',
        name: 'Saloon Zero',
        description: 'Signs of irritation and dryness across key areas',
        imageUrl: 'assets/images/salons/saloon_zero.jpg',
        category: 'Spa',
      ),
    ];
  }
}
