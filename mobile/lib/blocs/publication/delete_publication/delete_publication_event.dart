part of 'delete_publication_bloc.dart';

@immutable
sealed class DeletePublicationEvent {}

class DeletePublication extends DeletePublicationEvent {
  final String uuidPublicacion;
  DeletePublication(this.uuidPublicacion);
}
