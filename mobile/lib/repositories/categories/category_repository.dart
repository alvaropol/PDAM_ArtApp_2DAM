import 'package:flutter_application_art/models/response/category/category_detail_response.dart';
import 'package:flutter_application_art/models/response/category/get_categories_form.dart';
import 'package:flutter_application_art/models/response/category/get_category_response.dart';

abstract class CategoryRepository {
  Future<GetCategoryResponse> getCategoriesPaged(int offset);
  Future<CategoryDetailResponse> getCategoryByUuid(String uuid);
  Future<List<GetCategoriesForm>> getCategoriesForm();
}
