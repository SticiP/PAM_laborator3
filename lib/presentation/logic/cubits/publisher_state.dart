import 'package:equatable/equatable.dart';
import '../../../../domain/entities/publisher_details_entity.dart';

abstract class PublisherState extends Equatable {
  const PublisherState();

  @override
  List<Object?> get props => [];
}

class PublisherInitial extends PublisherState {}

class PublisherLoading extends PublisherState {}

class PublisherLoaded extends PublisherState {
  final PublisherDetailsEntity details;

  const PublisherLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class PublisherError extends PublisherState {
  final String message;

  const PublisherError(this.message);

  @override
  List<Object?> get props => [message];
}