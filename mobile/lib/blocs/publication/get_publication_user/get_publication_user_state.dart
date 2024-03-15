part of 'get_publication_user_bloc.dart';

@immutable
sealed class GetPublicationUserState {}

final class GetPublicationUserInitial extends GetPublicationUserState {}

final class GetPublicationUserSuccess extends GetPublicationUserState {
  final List<PublicationDetailResponse> response;
  GetPublicationUserSuccess(this.response);
}

final class GetPublicationUserError extends GetPublicationUserState {
  final String errorMessage;
  GetPublicationUserError(this.errorMessage);
}
