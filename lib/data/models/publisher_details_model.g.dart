// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publisher_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublisherDetailsModel _$PublisherDetailsModelFromJson(
  Map<String, dynamic> json,
) => PublisherDetailsModel(
  publisher: PublisherInfoModel.fromJson(
    json['publisher'] as Map<String, dynamic>,
  ),
  news: (json['news'] as List<dynamic>)
      .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

PublisherInfoModel _$PublisherInfoModelFromJson(Map<String, dynamic> json) =>
    PublisherInfoModel(
      username: json['username'] as String,
      name: json['name'] as String,
      isVerified: json['verified'] as bool,
      logo: json['logo'] as String,
      bio: json['bio'] as String,
      stats: PublisherStatsModel.fromJson(
        json['stats'] as Map<String, dynamic>,
      ),
      isFollowing: json['is_following'] as bool,
    );

PublisherStatsModel _$PublisherStatsModelFromJson(Map<String, dynamic> json) =>
    PublisherStatsModel(
      newsCount: json['news_count'] as String,
      followers: json['followers'] as String,
      following: (json['following'] as num).toInt(),
    );

Map<String, dynamic> _$PublisherStatsModelToJson(
  PublisherStatsModel instance,
) => <String, dynamic>{
  'news_count': instance.newsCount,
  'followers': instance.followers,
  'following': instance.following,
};
