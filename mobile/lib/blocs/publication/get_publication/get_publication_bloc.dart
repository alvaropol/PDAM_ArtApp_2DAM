import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/publication/get_publication_response.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'get_publication_event.dart';
part 'get_publication_state.dart';

class GetPublicationBloc
    extends Bloc<GetPublicationEvent, GetPublicationState> {
  final PublicationRepository publicationRepository;

  GetPublicationBloc(this.publicationRepository)
      : super(GetPublicationInitial()) {
    on<GetPublicationList>((_onPublicationList));
  }

  FutureOr<void> _onPublicationList(
      GetPublicationList event, Emitter<GetPublicationState> emit) async {
    try {
      final publicationResponse =
          await publicationRepository.getPublicationsPaged(event.offset);
      emit(GetPublicationSuccess(publicationResponse));
    } on Exception catch (e) {
      emit(GetPublicationError(e.toString()));
    }
  }
}
