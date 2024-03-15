part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountDetailLoading extends AccountState {}

final class AccountDetailSuccess extends AccountState {
  final AccountDetailResponse response;
  AccountDetailSuccess(this.response);
}

final class AccountDetailError extends AccountState {
  final String errorMessage;
  AccountDetailError(this.errorMessage);
}

final class AddToFavoriteSuccess extends AccountState {
  final String publicationUuid;
  AddToFavoriteSuccess(this.publicationUuid);
}

final class AddToFavoriteError extends AccountState {
  final String errorMessage;
  AddToFavoriteError(this.errorMessage);
}

class RemoveFromFavoriteSuccess extends AccountState {
  final String publicationUuid;
  RemoveFromFavoriteSuccess(this.publicationUuid);
}

final class RemoveFromFavoriteError extends AccountState {
  final String errorMessage;
  RemoveFromFavoriteError(this.errorMessage);
}
