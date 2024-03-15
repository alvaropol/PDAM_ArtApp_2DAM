import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/publication/publication_detail_response.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'publication_detail_event.dart';
part 'publication_detail_state.dart';

class PublicationDetailBloc
    extends Bloc<PublicationDetailEvent, PublicationDetailState> {
  final PublicationRepository publicationRepository;
  PublicationDetailBloc(this.publicationRepository)
      : super(PublicationDetailInitial()) {
    on<GetPublicationDetail>((_onPublicationDetail));
  }

  FutureOr<void> _onPublicationDetail(
      GetPublicationDetail event, Emitter<PublicationDetailState> emit) async {
    try {
      final publicationResponse =
          await publicationRepository.getPublicationByUuid(event.uuid);
      emit(PublicationDetailSuccess(publicationResponse));
    } on Exception catch (e) {
      emit(PublicationDetailError(e.toString()));
    }
  }
}
