// lib/domain/entities/user_entity.dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String profileImage;
  final int notificationCount;

  const UserEntity({
    required this.name,
    required this.profileImage,
    required this.notificationCount,
  });

  @override
  List<Object?> get props => [name, profileImage, notificationCount];
}