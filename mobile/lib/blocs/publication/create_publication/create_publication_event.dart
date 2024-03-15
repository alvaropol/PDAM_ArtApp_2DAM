part of 'create_publication_bloc.dart';

@immutable
sealed class CreatePublicationEvent {}

class CreatePublication extends CreatePublicationEvent {
  final String? titulo;
  final String? descripcion;
  final String? tamanyoDimensiones;
  final String? direccionObra;
  final String? nombreMuseo;
  final String? lat;
  final String? lon;
  final String? image;
  final int? numeroCategoria;
  CreatePublication(
      this.titulo,
      this.descripcion,
      this.tamanyoDimensiones,
      this.direccionObra,
      this.nombreMuseo,
      this.lat,
      this.lon,
      this.image,
      this.numeroCategoria);
}
