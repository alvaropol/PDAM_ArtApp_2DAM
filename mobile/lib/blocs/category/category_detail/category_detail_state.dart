part of 'category_detail_bloc.dart';

@immutable
sealed class CategoryDetailState {}

final class CategoryDetailInitial extends CategoryDetailState {}

final class CategoryDetailLoading extends CategoryDetailState {}

final class CategoryDetailSuccess extends CategoryDetailState {
  final CategoryDetailResponse response;
  CategoryDetailSuccess(this.response);
}

final class CategoryDetailError extends CategoryDetailState {
  final String errorMessage;
  CategoryDetailError(this.errorMessage);
}
