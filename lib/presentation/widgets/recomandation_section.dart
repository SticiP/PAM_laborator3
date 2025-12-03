import 'package:flutter/material.dart';
import '../../domain/entities/news_entity.dart';
import 'recommendation_card.dart';

class RecommendationSection extends StatelessWidget {
  final List<NewsEntity> items; // Lista de entitati
  final VoidCallback? onSeeAll;

  const RecommendationSection({
    super.key,
    required this.items,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recommended",
              style: TextStyle(
                color: Color(0xFF191919),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll ?? () => debugPrint("See all pressed"),
              child: const Text(
                "See all",
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Lista verticala
        Column(
          children: List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              // Acum RecommendationCard stie sa primeasca NewsEntity
              child: RecommendationCard(item: item),
            );
          }),
        ),
      ],
    );
  }
}