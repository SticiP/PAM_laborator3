import 'package:flutter/material.dart';
import '../../domain/entities/news_entity.dart';
import '../pages/profile_page.dart';
import 'custom_network_image.dart';

class RecommendationCard extends StatelessWidget {
  // Primim direct entitatea
  final NewsEntity item;
  final VoidCallback? onFollow;

  const RecommendationCard({
    super.key,
    required this.item,
    this.onFollow,
  });

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfilePage(
            sourceName: item.publisher,
            sourceImagePath: item.publisherIcon
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF9FCFE),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header cu poza publisher + nume + buton follow
          Row(
            children: [
              GestureDetector(
                onTap: () => _openProfile(context),
                child: ClipOval(
                  child: SizedBox(
                    width: 36, // 2 * radius (18)
                    height: 36,
                    child: CustomNetworkImage(imageUrl: item.publisherIcon),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _openProfile(context),
                      child: Text(
                        item.publisher,
                        style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      item.date,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onFollow ?? () => debugPrint('Follow pressed'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color(0x12121214),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                      color: Color(0xFF121214),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Titlu
          Text(
            item.title,
            style: const TextStyle(
              color: Color(0xFF191919),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          // Tag Categorie
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF2ABAFF), width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              item.category,
              style: const TextStyle(
                color: Color(0xFF2ABAFF),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Imagine mare (Card Image)
          Container(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}