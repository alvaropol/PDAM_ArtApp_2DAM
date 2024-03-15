import 'package:flutter_application_art/models/response/auth/account_detail.dart';

abstract class AccountRepository {
  Future<AccountDetailResponse> getAccountDetail();
  Future<void> addToFavorite(String publicationUuid);
  Future<void> removeFavorite(String publicationUuid);
}
