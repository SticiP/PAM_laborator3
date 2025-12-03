// lib/domain/entities/news_entity.dart
import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final int id;
  final String category;
  final String title;
  final String publisher;
  final String publisherIcon; // URL pentru iconita publisher
  final String image;         // Imaginea mare a știrii
  final String date;
  final bool isVerified;
  final bool isFollowing;     // Opțional (poate fi null sau false default)

  const NewsEntity({
    required this.id,
    required this.category,
    required this.title,
    required this.publisher,
    required this.publisherIcon,
    required this.image,
    required this.date,
    this.isVerified = false,
    this.isFollowing = false,
  });

  @override
  List<Object?> get props => [id, title, category, publisher, date];
}