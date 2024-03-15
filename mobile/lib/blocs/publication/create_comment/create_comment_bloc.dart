import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/dto/publication/create_comment_publication_dto.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  final PublicationRepository publicationRepository;
  CreateCommentBloc(this.publicationRepository)
      : super(CreateCommentInitial()) {
    on<CreateComment>(_onCreateComment);
  }

  void _onCreateComment(
      CreateComment event, Emitter<CreateCommentState> emit) async {
    final CreateCommentPublicationDTO createCommentDTO =
        CreateCommentPublicationDTO(comment: event.comment);
    await publicationRepository.createCommentInPublication(
        createCommentDTO, event.uuid);
    emit(CreateCommentSuccess());
  }
}
