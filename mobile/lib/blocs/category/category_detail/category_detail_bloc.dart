import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/category/category_detail_response.dart';
import 'package:flutter_application_art/repositories/categories/category_repository.dart';
import 'package:meta/meta.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final CategoryRepository categoryRepository;

  CategoryDetailBloc(this.categoryRepository) : super(CategoryDetailInitial()) {
    on<GetCategoryDetail>((_onCategoryDetail));
  }

  FutureOr<void> _onCategoryDetail(
      GetCategoryDetail event, Emitter<CategoryDetailState> emit) async {
    try {
      final publicationResponse =
          await categoryRepository.getCategoryByUuid(event.uuid);
      emit(CategoryDetailSuccess(publicationResponse));
    } on Exception catch (e) {
      emit(CategoryDetailError(e.toString()));
    }
  }
}
