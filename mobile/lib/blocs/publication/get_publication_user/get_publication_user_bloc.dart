import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/publication/publication_detail_response.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'get_publication_user_event.dart';
part 'get_publication_user_state.dart';

class GetPublicationUserBloc
    extends Bloc<GetPublicationUserEvent, GetPublicationUserState> {
  final PublicationRepository publicationRepository;
  GetPublicationUserBloc(this.publicationRepository)
      : super(GetPublicationUserInitial()) {
    on<GetPublicationsUser>(_onGetPublicationsUser);
  }
  FutureOr<void> _onGetPublicationsUser(
      GetPublicationsUser event, Emitter<GetPublicationUserState> emit) async {
    try {
      final publicationListResponse =
          await publicationRepository.getPublicationsOfUser();
      emit(GetPublicationUserSuccess(publicationListResponse));
    } on Exception catch (e) {
      emit(GetPublicationUserError(e.toString()));
    }
  }
}
