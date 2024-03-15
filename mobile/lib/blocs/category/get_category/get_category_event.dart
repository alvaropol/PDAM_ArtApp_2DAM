part of 'get_category_bloc.dart';

@immutable
sealed class GetCategoryEvent {}

class GetCategoryList extends GetCategoryEvent {
  final int offset;
  GetCategoryList(this.offset);
}

class GetCategoriesFormEvent extends GetCategoryEvent {
  GetCategoriesFormEvent();
}
