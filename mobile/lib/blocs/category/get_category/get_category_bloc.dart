import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/category/get_categories_form.dart';
import 'package:flutter_application_art/models/response/category/get_category_response.dart';
import 'package:flutter_application_art/repositories/categories/category_repository.dart';
import 'package:meta/meta.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final CategoryRepository categoryRepository;
  GetCategoryBloc(this.categoryRepository) : super(GetCategoryInitial()) {
    on<GetCategoryList>((_onCategoryList));
    on<GetCategoriesFormEvent>((_onCategoriesForm));
  }

  FutureOr<void> _onCategoryList(
      GetCategoryList event, Emitter<GetCategoryState> emit) async {
    try {
      final categoryResponse =
          await categoryRepository.getCategoriesPaged(event.offset);
      emit(GetCategorySuccess(categoryResponse));
    } on Exception catch (e) {
      emit(GetCategoryError(e.toString()));
    }
  }

  FutureOr<void> _onCategoriesForm(
      GetCategoriesFormEvent event, Emitter<GetCategoryState> emit) async {
    try {
      final categoriesResponse = await categoryRepository.getCategoriesForm();
      emit(GetCategoriesFormSuccess(categoriesResponse));
    } on Exception catch (e) {
      emit(GetCategoryError(e.toString()));
    }
  }
}
