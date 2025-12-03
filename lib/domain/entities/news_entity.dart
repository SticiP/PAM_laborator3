import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final int id;
  final String title;
  final String category;
  final String imageUrl;
  final String date;
  final String publisher;
  final String publisherIcon;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.date,
    required this.publisher,
    required this.publisherIcon,
  });

  @override
  List<Object?> get props => [id, title, category, imageUrl, date, publisher];
}