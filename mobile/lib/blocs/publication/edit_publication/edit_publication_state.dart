part of 'edit_publication_bloc.dart';

@immutable
sealed class EditPublicationState {}

final class EditPublicationInitial extends EditPublicationState {}

final class EditPublicationSuccess extends EditPublicationState {}

final class EditPublicationLoading extends EditPublicationState {}

final class EditPublicationError extends EditPublicationState {
  final String errorMessage;
  EditPublicationError(this.errorMessage);
}
