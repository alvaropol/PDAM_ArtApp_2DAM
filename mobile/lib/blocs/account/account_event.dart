part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class GetAccountDetail extends AccountEvent {
  GetAccountDetail();
}

class AddToFavorite extends AccountEvent {
  final String publicationUuid;
  AddToFavorite(this.publicationUuid);
}

class RemoveFromFavorite extends AccountEvent {
  final String publicationUuid;
  RemoveFromFavorite(this.publicationUuid);
}
