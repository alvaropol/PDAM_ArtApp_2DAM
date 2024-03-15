part of 'create_publication_bloc.dart';

@immutable
sealed class CreatePublicationState {}

final class CreatePublicationInitial extends CreatePublicationState {}

final class CreatePublicationSuccess extends CreatePublicationState {}

final class CreatePublicationLoading extends CreatePublicationState {}

final class CreatePublicationError extends CreatePublicationState {
  final String errorMessage;
  CreatePublicationError(this.errorMessage);
}
