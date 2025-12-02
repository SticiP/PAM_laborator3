// lib/widgets/recommendation_card.dart
import 'package:flutter/material.dart';
import '../pages/profile_page.dart';

class RecommendationCard extends StatelessWidget {
  final String profileImagePath;
  final String sourceName;
  final String date;
  final String title;
  final String cardImagePath;
  final VoidCallback? onFollow;
  final VoidCallback? onMoreTap;

  const RecommendationCard({
    super.key,
    required this.profileImagePath,
    required this.sourceName,
    required this.date,
    required this.title,
    required this.cardImagePath,
    this.onFollow,
    this.onMoreTap,
  });

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfilePage(
            sourceName: sourceName,
            sourceImagePath: profileImagePath
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
          // header cu poza + nume + follow
          Row(
            children: [
              GestureDetector(
                onTap: () => _openProfile(context),
                child: Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 12),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                  child: Image.asset(
                    profileImagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _openProfile(context),
                      child: Row(
                        children: [
                          Text(
                            sourceName,
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 18,
                            height: 18,
                            child: Image.network(
                              "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/trms4kt7_expires_30_days.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 16,
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
                  padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 9),
                  margin: const EdgeInsets.only(right: 14),
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                      color: Color(0xFF121214),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              Container(
                width: 24,
                height: 24,
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/fLkPA1dKLS/779a7rkm_expires_30_days.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF191919),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => debugPrint('Business category pressed'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2ABAFF), width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: const Text(
                "Business",
                style: TextStyle(
                  color: Color(0xFF2ABAFF),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            height: 198,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: cardImagePath.startsWith('http')
                    ? NetworkImage(cardImagePath) as ImageProvider
                    : AssetImage(cardImagePath), // suport pentru asset sau network
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
