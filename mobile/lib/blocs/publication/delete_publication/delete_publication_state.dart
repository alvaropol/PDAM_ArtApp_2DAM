part of 'delete_publication_bloc.dart';

@immutable
sealed class DeletePublicationState {}

final class DeletePublicationInitial extends DeletePublicationState {}

final class DeletePublicationSuccess extends DeletePublicationState {}

final class DeletePublicationError extends DeletePublicationState {
  final String errorMessage;
  DeletePublicationError(this.errorMessage);
}
