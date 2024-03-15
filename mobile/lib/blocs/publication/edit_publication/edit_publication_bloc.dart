import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/dto/publication/create_publication_dto.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'edit_publication_event.dart';
part 'edit_publication_state.dart';

class EditPublicationBloc
    extends Bloc<EditPublicationEvent, EditPublicationState> {
  final PublicationRepository publicationRepository;
  EditPublicationBloc(this.publicationRepository)
      : super(EditPublicationInitial()) {
    on<EditPublication>(_onEditPublication);
  }

  void _onEditPublication(
      EditPublication event, Emitter<EditPublicationState> emit) async {
    emit(EditPublicationLoading());
    try {
      final CreatePublicationDTO publicationDTO = CreatePublicationDTO(
          titulo: event.titulo,
          descripcion: event.descripcion,
          tamanyoDimensiones: event.tamanyoDimensiones,
          direccionObra: event.direccionObra,
          nombreMuseo: event.nombreMuseo,
          image: event.image,
          lat: event.lat,
          lon: event.lon,
          numeroCategoria: event.numeroCategoria);
      await publicationRepository.editPublication(
          event.uuidPublicacion, publicationDTO);
      emit(EditPublicationSuccess());
    } on Exception catch (e) {
      emit(EditPublicationError(e.toString()));
    }
  }
}
