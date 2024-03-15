import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'delete_publication_event.dart';
part 'delete_publication_state.dart';

class DeletePublicationBloc
    extends Bloc<DeletePublicationEvent, DeletePublicationState> {
  final PublicationRepository publicationRepository;
  DeletePublicationBloc(this.publicationRepository)
      : super(DeletePublicationInitial()) {
    on<DeletePublication>(_onRemoveFromFavorite);
  }

  FutureOr<void> _onRemoveFromFavorite(
      DeletePublication event, Emitter<DeletePublicationState> emit) async {
    try {
      await publicationRepository.removePublication(event.uuidPublicacion);
      emit(DeletePublicationSuccess());
    } on Exception catch (e) {
      emit(DeletePublicationError(e.toString()));
    }
  }
}
