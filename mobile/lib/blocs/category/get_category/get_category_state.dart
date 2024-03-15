part of 'get_category_bloc.dart';

@immutable
sealed class GetCategoryState {}

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategoryLoading extends GetCategoryState {}

final class GetCategorySuccess extends GetCategoryState {
  final GetCategoryResponse response;
  GetCategorySuccess(this.response);
}

final class GetCategoryError extends GetCategoryState {
  final String errorMessage;
  GetCategoryError(this.errorMessage);
}

final class GetCategoriesFormSuccess extends GetCategoryState {
  final List<GetCategoriesForm> response;
  GetCategoriesFormSuccess(this.response);
}
