part of 'category_detail_bloc.dart';

@immutable
sealed class CategoryDetailEvent {}

class GetCategoryDetail extends CategoryDetailEvent {
  final String uuid;
  GetCategoryDetail(this.uuid);
}
