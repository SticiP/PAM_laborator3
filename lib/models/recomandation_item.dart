import 'dart:ui';

class RecommendationItem {
  final String profileImagePath;
  final String sourceName;
  final String date;
  final String title;
  final String cardImagePath;
  final VoidCallback? onFollow;

  RecommendationItem({
    required this.profileImagePath,
    required this.sourceName,
    required this.date,
    required this.title,
    required this.cardImagePath,
    this.onFollow,
  });
}
