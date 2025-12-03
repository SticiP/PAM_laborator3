import '../../domain/entities/publisher_details_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/local_news_datasource.dart';
import '../datasources/remote_news_datasource.dart';
import '../models/user_model.dart';
import '../models/news_model.dart';
import '../models/publisher_details_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final LocalNewsDataSource localDataSource;
  final RemoteNewsDataSource remoteDataSource;

  NewsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<HomeDataEntity> getHomeData() async {
    Map<String, dynamic> jsonMap;

    try {
      // 1. INCERCAM DE PE NET
      print("📡 Attempting to fetch Feed from API...");
      jsonMap = await remoteDataSource.getFeed();
      print("✅ Feed loaded from API");
    } catch (e) {
      // 2. DACA CRAPA (nu avem net, eroare server), LUAM LOCAL
      print("⚠️ API Failed ($e). Loading from LOCAL JSON...");
      jsonMap = await localDataSource.loadNewsData();
    }

    // De aici in jos logica e aceeasi, indiferent de sursa
    // JSON-ul tau nou nu mai are cheia "news_app", e direct root-ul
    final data = jsonMap;

    final user = UserModel.fromJson(data['user']);

    final trendingList = (data['trending_news'] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList();

    final recommendationList = (data['recommendations'] as List)
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
    Map<String, dynamic> jsonMap;

    try {
      // 1. INCERCAM DE PE NET
      print("📡 Attempting to fetch Details from API...");
      jsonMap = await remoteDataSource.getDetails();
      print("✅ Details loaded from API");
    } catch (e) {
      // 2. FALLBACK LA LOCAL
      print("⚠️ API Failed ($e). Loading from LOCAL JSON...");
      jsonMap = await localDataSource.loadPublisherDetails();
    }

    // JSON-ul tau nou de detalii (daca l-ai modificat sa nu mai aiba "news_app_details")
    // Daca API-ul returneaza direct obiectul publisher (fara lista), folosim direct jsonMap
    // Daca API-ul returneaza lista (ca in exemplul cu BBC/NYT), trebuie sa adaptam.

    // Verificam structura: Daca API returneaza un singur obiect (mock-ul simplu):
    return PublisherDetailsModel.fromJson(jsonMap);
  }
}