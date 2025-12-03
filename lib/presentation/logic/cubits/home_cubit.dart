import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/news_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NewsRepository repository;

  // Initial, pornim cu starea HomeInitial
  HomeCubit({required this.repository}) : super(HomeInitial());

  // Aceasta este functia pe care o va apela UI-ul
  Future<void> loadHomeData() async {
    try {
      // 1. Emitem starea de incarcare (UI-ul va arata spinner-ul)
      emit(HomeLoading());

      // 2. Cerem datele de la repository
      final data = await repository.getHomeData();

      // 3. Daca totul e ok, emitem starea Loaded cu datele
      emit(HomeLoaded(data));

    } catch (e) {
      // 4. Daca apare o eroare emitem Error
      emit(HomeError("Failed to load news: $e"));
    }
  }
}