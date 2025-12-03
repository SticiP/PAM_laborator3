// lib/data/models/news_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_entity.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel extends NewsEntity {
  const NewsModel({
    required int id,
    required String category,
    required String title,
    required String publisher,

    // --- MODIFICARE AICI ---
    // API-ul de detalii nu trimite iconita, asa ca punem una default (un cerc gri sau o imagine de placeholder)
    @JsonKey(name: 'publisher_icon', defaultValue: 'https://cdn-icons-png.flaticon.com/512/149/149071.png')
    required String publisherIcon,
    // -----------------------

    required String image,
    required String date,
    @JsonKey(name: 'is_verified') bool isVerified = false,
    @JsonKey(name: 'is_following') bool isFollowing = false,
  }) : super(
    id: id,
    category: category,
    title: title,
    publisher: publisher,
    publisherIcon: publisherIcon,
    image: image,
    date: date,
    isVerified: isVerified,
    isFollowing: isFollowing,
  );

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}