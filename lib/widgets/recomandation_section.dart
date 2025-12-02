import 'package:flutter/material.dart';
import '../models/recomandation_item.dart';
import 'recommendation_card.dart';

class RecommendationSection extends StatelessWidget {
  final List<RecommendationItem> items;
  final VoidCallback? onSeeAll;
  final double verticalSpacing;

  const RecommendationSection({
    super.key,
    required this.items,
    this.onSeeAll,
    this.verticalSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
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

        // Lista verticală de carduri
        Column(
          children: List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : verticalSpacing),
              child: RecommendationCard(
                profileImagePath: item.profileImagePath,
                sourceName: item.sourceName,
                date: item.date,
                title: item.title,
                cardImagePath: item.cardImagePath,
                onFollow: item.onFollow,
              ),
            );
          }),
        ),
      ],
    );
  }
}
