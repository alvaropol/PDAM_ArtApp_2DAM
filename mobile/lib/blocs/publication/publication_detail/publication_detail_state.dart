part of 'publication_detail_bloc.dart';

@immutable
sealed class PublicationDetailState {}

final class PublicationDetailInitial extends PublicationDetailState {}

final class GetPublicationLoading extends PublicationDetailState {}

final class PublicationDetailSuccess extends PublicationDetailState {
  final PublicationDetailResponse response;
  PublicationDetailSuccess(this.response);
}

final class PublicationDetailError extends PublicationDetailState {
  final String errorMessage;
  PublicationDetailError(this.errorMessage);
}
