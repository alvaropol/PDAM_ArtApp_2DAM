import 'dart:convert';

import 'package:flutter_application_art/models/response/category/category_detail_response.dart';
import 'package:flutter_application_art/models/response/category/get_categories_form.dart';
import 'package:flutter_application_art/models/response/category/get_category_response.dart';
import 'package:flutter_application_art/repositories/categories/category_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final Client _httpClient = Client();
  @override
  Future<GetCategoryResponse> getCategoriesPaged(int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient.get(
        Uri.parse('http://10.0.2.2:8080/categories/paged?offset=$offset'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      return GetCategoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories list');
    }
  }

  @override
  Future<CategoryDetailResponse> getCategoryByUuid(String uuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient
        .get(Uri.parse('http://10.0.2.2:8080/category/$uuid'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return CategoryDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load category');
    }
  }

  @override
  Future<List<GetCategoriesForm>> getCategoriesForm() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient
        .get(Uri.parse('http://10.0.2.2:8080/categories/createform'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GetCategoriesForm.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories list');
    }
  }
}
