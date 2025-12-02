// lib/models/news_item.dart
class NewsItem {
  final String imagePath;
  final String category;
  final String title;
  final String? sourceImageProfilePath;
  final String source;
  final String date;

  NewsItem({
    required this.imagePath,
    required this.category,
    required this.title,
    this.sourceImageProfilePath,
    required this.source,
    required this.date,
  });
}
