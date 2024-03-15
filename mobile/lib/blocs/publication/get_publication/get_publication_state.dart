part of 'get_publication_bloc.dart';

@immutable
sealed class GetPublicationState {}

final class GetPublicationInitial extends GetPublicationState {}

final class GetPublicationLoading extends GetPublicationState {}

final class GetPublicationSuccess extends GetPublicationState {
  final GetPublicationResponse response;
  GetPublicationSuccess(this.response);
}

final class GetPublicationError extends GetPublicationState {
  final String errorMessage;
  GetPublicationError(this.errorMessage);
}
