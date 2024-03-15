import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/auth/account_detail.dart';
import 'package:flutter_application_art/repositories/account/account_repository.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;
  AccountBloc(this.accountRepository) : super(AccountInitial()) {
    on<GetAccountDetail>((_onAccountDetail));
    on<AddToFavorite>((_onAddToFavorite));
    on<RemoveFromFavorite>((_onRemoveFromFavorite));
  }

  FutureOr<void> _onAccountDetail(
      GetAccountDetail event, Emitter<AccountState> emit) async {
    try {
      final accountResponse = await accountRepository.getAccountDetail();
      emit(AccountDetailSuccess(accountResponse));
    } on Exception catch (e) {
      emit(AccountDetailError(e.toString()));
    }
  }

  FutureOr<void> _onAddToFavorite(
      AddToFavorite event, Emitter<AccountState> emit) async {
    try {
      await accountRepository.addToFavorite(event.publicationUuid);
      emit(AddToFavoriteSuccess(event.publicationUuid));
    } on Exception catch (e) {
      emit(AddToFavoriteError(e.toString()));
    }
  }

  FutureOr<void> _onRemoveFromFavorite(
      RemoveFromFavorite event, Emitter<AccountState> emit) async {
    try {
      await accountRepository.removeFavorite(event.publicationUuid);
      emit(RemoveFromFavoriteSuccess(event.publicationUuid));
    } on Exception catch (e) {
      emit(RemoveFromFavoriteError(e.toString()));
    }
  }
}
