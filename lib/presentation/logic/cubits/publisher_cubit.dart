import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/news_repository.dart';
import 'publisher_state.dart';

class PublisherCubit extends Cubit<PublisherState> {
  final NewsRepository repository;

  PublisherCubit({required this.repository}) : super(PublisherInitial());

  Future<void> loadPublisherDetails(String id) async {
    emit(PublisherLoading());
    try {
      // Apelam functia din repository
      // (Momentan id-ul e ignorat in mock, dar e bine sa il avem pentru viitor)
      final details = await repository.getPublisherDetails(id);

      emit(PublisherLoaded(details));
    } catch (e) {
      emit(PublisherError("Failed to load publisher details: $e"));
    }
  }
}