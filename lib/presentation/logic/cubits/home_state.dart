import 'package:equatable/equatable.dart';
import '../../../../domain/repositories/news_repository.dart';

// Clasa de baza abstracta
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// Starea 1: Initiala (cand deschizi aplicatia)
class HomeInitial extends HomeState {}

// Starea 2: Se incarca datele (afisam loader)
class HomeLoading extends HomeState {}

// Starea 3: Avem datele! (afisam lista)
class HomeLoaded extends HomeState {
  final HomeDataEntity data; // Aici tinem datele primite

  const HomeLoaded(this.data);

  @override
  List<Object?> get props => [data]; // Important pentru comparatie
}

// Starea 4: Eroare
class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}