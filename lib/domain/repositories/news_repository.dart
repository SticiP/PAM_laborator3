// lib/domain/repositories/news_repository.dart
import '../entities/news_entity.dart';
import '../entities/publisher_details_entity.dart';
import '../entities/user_entity.dart';

// O clasă simplă care grupează tot ce avem nevoie pentru Home Page
class HomeDataEntity {
  final UserEntity user;
  final List<NewsEntity> trendingNews;
  final List<NewsEntity> recommendations;

  HomeDataEntity({
    required this.user,
    required this.trendingNews,
    required this.recommendations,
  });
}

// Contractul (Interfața) - Definim CE metode avem, nu CUM funcționează
abstract class NewsRepository {
  // Metoda care va returna toate datele pentru Home Page
  Future<HomeDataEntity> getHomeData();

  // Pe viitor, pentru Lab 3 (partea 2) - Detalii Publisher
  Future<PublisherDetailsEntity> getPublisherDetails(String id);
}