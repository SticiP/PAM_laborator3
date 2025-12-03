import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/publisher_details_entity.dart';
import 'news_model.dart';

part 'publisher_details_model.g.dart';

// ==============================================================================
// 1. PublisherDetailsModel
// ==============================================================================
@JsonSerializable(createToJson: false) // Oprim generarea automată pentru toJson
class PublisherDetailsModel extends PublisherDetailsEntity {
  const PublisherDetailsModel({
    required PublisherInfoModel publisher,
    required List<NewsModel> news,
  }) : super(publisher: publisher, news: news);

  factory PublisherDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherDetailsModelFromJson(json);

  // Scriem MANUAL toJson pentru a face conversia corectă (Cast la Model)
  Map<String, dynamic> toJson() {
    return {
      'publisher': (publisher as PublisherInfoModel).toJson(),
      'news': news.map((e) => (e as NewsModel).toJson()).toList(),
    };
  }
}

// ==============================================================================
// 2. PublisherInfoModel
// ==============================================================================
@JsonSerializable(createToJson: false) // Oprim generarea automată pentru toJson
class PublisherInfoModel extends PublisherInfoEntity {
  const PublisherInfoModel({
    required String username,
    required String name,
    @JsonKey(name: 'verified') required bool isVerified,
    required String logo,
    required String bio,
    required PublisherStatsModel stats,
    @JsonKey(name: 'is_following') required bool isFollowing,
  }) : super(
    username: username,
    name: name,
    isVerified: isVerified,
    logo: logo,
    bio: bio,
    stats: stats,
    isFollowing: isFollowing,
  );

  factory PublisherInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherInfoModelFromJson(json);

  // Scriem MANUAL toJson (atentie la cheile JSON, trebuie să coincidă cu @JsonKey)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'verified': isVerified, // Cheia din JSON
      'logo': logo,
      'bio': bio,
      'stats': (stats as PublisherStatsModel).toJson(), // Cast la Model
      'is_following': isFollowing, // Cheia din JSON
    };
  }
}

// ==============================================================================
// 3. PublisherStatsModel
// ==============================================================================
// Aici NU avem nevoie de manual toJson, deoarece conține doar String și Int (primitive)
@JsonSerializable()
class PublisherStatsModel extends PublisherStatsEntity {
  const PublisherStatsModel({
    @JsonKey(name: 'news_count') required String newsCount,
    required String followers,
    required int following,
  }) : super(
    newsCount: newsCount,
    followers: followers,
    following: following,
  );

  factory PublisherStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherStatsModelToJson(this);
}