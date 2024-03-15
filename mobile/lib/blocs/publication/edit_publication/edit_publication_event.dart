part of 'edit_publication_bloc.dart';

@immutable
sealed class EditPublicationEvent {}

class EditPublication extends EditPublicationEvent {
  final String? titulo;
  final String? descripcion;
  final String? tamanyoDimensiones;
  final String? direccionObra;
  final String? nombreMuseo;
  final String? lat;
  final String? lon;
  final String? image;
  final int? numeroCategoria;
  final String uuidPublicacion;
  EditPublication(
      this.titulo,
      this.descripcion,
      this.tamanyoDimensiones,
      this.direccionObra,
      this.nombreMuseo,
      this.lat,
      this.lon,
      this.image,
      this.numeroCategoria,
      this.uuidPublicacion);
}
