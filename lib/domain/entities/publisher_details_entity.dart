import 'package:equatable/equatable.dart';
import 'news_entity.dart';

// 1. Entitatea Principală (Wrapper-ul care tine tot)
class PublisherDetailsEntity extends Equatable {
  final PublisherInfoEntity publisher;
  final List<NewsEntity> news; // Lista de stiri a publisherului

  const PublisherDetailsEntity({
    required this.publisher,
    required this.news,
  });

  @override
  List<Object?> get props => [publisher, news];
}

// 2. Informațiile despre Publisher (Nume, Bio, Logo)
class PublisherInfoEntity extends Equatable {
  final String username;
  final String name;
  final bool isVerified;
  final String logo;
  final String bio;
  final PublisherStatsEntity stats; // Statisicile sunt alt obiect
  final bool isFollowing;

  const PublisherInfoEntity({
    required this.username,
    required this.name,
    required this.isVerified,
    required this.logo,
    required this.bio,
    required this.stats,
    required this.isFollowing,
  });

  @override
  List<Object?> get props => [username, name, isFollowing];
}

// 3. Statisticile (Numerele)
class PublisherStatsEntity extends Equatable {
  final String newsCount;
  final String followers;
  final int following;

  const PublisherStatsEntity({
    required this.newsCount,
    required this.followers,
    required this.following,
  });

  @override
  List<Object?> get props => [newsCount, followers, following];
}