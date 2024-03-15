import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/dto/publication/create_publication_dto.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:meta/meta.dart';

part 'create_publication_event.dart';
part 'create_publication_state.dart';

class CreatePublicationBloc
    extends Bloc<CreatePublicationEvent, CreatePublicationState> {
  final PublicationRepository publicationRepository;
  CreatePublicationBloc(this.publicationRepository)
      : super(CreatePublicationInitial()) {
    on<CreatePublication>(_onCreatePublication);
  }

  void _onCreatePublication(
      CreatePublication event, Emitter<CreatePublicationState> emit) async {
    emit(CreatePublicationLoading());
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
      await publicationRepository.createPublication(publicationDTO);
      emit(CreatePublicationSuccess());
    } on Exception catch (e) {
      emit(CreatePublicationError(e.toString()));
    }
  }
}
