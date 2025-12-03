// lib/data/repositories/news_repository_impl.dart
import '../../domain/repositories/news_repository.dart';
import '../datasources/local_news_datasource.dart';
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
}