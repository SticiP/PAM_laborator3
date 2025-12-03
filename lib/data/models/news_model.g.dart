// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
  id: (json['id'] as num).toInt(),
  category: json['category'] as String,
  title: json['title'] as String,
  publisher: json['publisher'] as String,
  publisherIcon: json['publisher_icon'] as String,
  image: json['image'] as String,
  date: json['date'] as String,
  isVerified: json['is_verified'] as bool? ?? false,
  isFollowing: json['is_following'] as bool? ?? false,
);

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'title': instance.title,
  'publisher': instance.publisher,
  'publisher_icon': instance.publisherIcon,
  'image': instance.image,
  'date': instance.date,
  'is_verified': instance.isVerified,
  'is_following': instance.isFollowing,
};
