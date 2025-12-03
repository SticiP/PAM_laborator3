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
    // 1. Luam JSON-ul brut (Map<String, dynamic>)
    final jsonMap = await dataSource.loadNewsData();

    // 2. Convertim User-ul
    final user = UserModel.fromJson(jsonMap['user']);

    // 3. Convertim listele
    final trendingList = (jsonMap['trending_news'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();

    final recommendationList = (jsonMap['recommendations'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();

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

    // 2. Convertim direct jsonMap-ul
    return PublisherDetailsModel.fromJson(jsonMap);
  }
}