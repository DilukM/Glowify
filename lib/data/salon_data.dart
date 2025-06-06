import '../models/salon_model.dart';

class SalonData {
  static List<SalonModel> getSalons() {
    return [
      // Featured salons
      SalonModel(
        id: '1',
        name: 'Adam & Eve',
        description: 'Premium hair styling and care',
        imageUrl: 'assets/img/img1.png',
        isFeatured: true,
        category: 'Hair',
      ),
      SalonModel(
        id: '2',
        name: 'Star Care',
        description: 'Facial and skin treatments',
        imageUrl: 'assets/img/img1.png',
        isFeatured: true,
        category: 'Facial',
      ),
      SalonModel(
        id: '3',
        name: 'Kandy Pearl',
        description: 'Hair coloring and styling experts',
        imageUrl: 'assets/img/img1.png',
        isFeatured: true,
        category: 'Hair',
      ),
      SalonModel(
        id: '4',
        name: 'Beauty Box',
        description: 'Full body massage and treatments',
        imageUrl: 'assets/img/img1.png',
        isFeatured: true,
        category: 'Spa',
      ),

      // Regular salons
      SalonModel(
        id: '5',
        name: 'Saloon Roo',
        description:
            'Signs of irritation and dryness across key areas with special treatments',
        imageUrl: 'assets/img/img1.png',
        category: 'Spa',
      ),
      SalonModel(
        id: '6',
        name: 'Saloon Zero',
        description:
            'Signs of irritation and dryness across key areas with organic products',
        imageUrl: 'assets/img/img1.png',
        category: 'Spa',
      ),
      SalonModel(
        id: '7',
        name: 'Green Leaf',
        description: 'Natural herbal treatments for skin and hair care',
        imageUrl: 'assets/img/img1.png',
        category: 'Herbal',
      ),
      SalonModel(
        id: '8',
        name: 'Nail Art Studio',
        description: 'Professional nail care and artistic designs',
        imageUrl: 'assets/img/img1.png',
        category: 'Nails',
      ),
      SalonModel(
        id: '9',
        name: 'Colombo Style',
        description: 'Modern haircuts and styling for all ages',
        imageUrl: 'assets/img/img1.png',
        category: 'Hair',
      ),
    ];
  }
}
