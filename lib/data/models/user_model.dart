// lib/data/models/user_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required String name,
    @JsonKey(name: 'profile_image') required String profileImage,
    @JsonKey(name: 'notification_count') required int notificationCount,
  }) : super(
    name: name,
    profileImage: profileImage,
    notificationCount: notificationCount,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}