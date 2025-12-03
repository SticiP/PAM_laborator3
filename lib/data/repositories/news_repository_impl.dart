// lib/data/repositories/news_repository_impl.dart
import 'package:news_app/domain/entities/publisher_details_entity.dart';

import '../../domain/repositories/news_repository.dart';
import '../datasources/local_news_datasource.dart';
import '../models/publisher_details_model.dart';
import '../models/user_model.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final LocalNewsDataSource dataSource;

  NewsRepositoryImpl({required this.dataSource});

  @override
  Future<HomeDataEntity> getHomeData() async {
    // 1. Luam JSON-ul brut
    final jsonMap = await dataSource.loadNewsData();

    // 2. Accesam cheia principala din JSON-ul tau ("news_app")
    final data = jsonMap['news_app'];

    // 3. Convertim User-ul
    final user = UserModel.fromJson(data['user']);

    // 4. Convertim listele. Folosim .map() pentru a transforma fiecare element JSON in Model
    final trendingList = (data['trending_news'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();

    final recommendationList = (data['recommendations'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();

    // 5. Returnam pachetul complet sub forma de Entitate de Domeniu
    return HomeDataEntity(
      user: user,
      trendingNews: trendingList,
      recommendations: recommendationList,
    );
  }

  @override
  Future<PublisherDetailsEntity> getPublisherDetails(String id) async {
    // 1. Citim Map-ul brut din DataSource
    final jsonMap = await dataSource.loadPublisherDetails();

    // 2. Extragem obiectul principal din JSON ("news_app_details")
    final detailsData = jsonMap['news_app_details'];

    // 3. Convertim JSON -> Model -> Entitate
    return PublisherDetailsModel.fromJson(detailsData);
  }
}