import 'dart:convert';

import 'package:flutter_application_art/models/response/auth/account_detail.dart';
import 'package:flutter_application_art/repositories/account/account_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountRepositoryImpl extends AccountRepository {
  final Client _httpClient = Client();
  @override
  Future<AccountDetailResponse> getAccountDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient
        .get(Uri.parse('http://10.0.2.2:8080/user/detail'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return AccountDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load account details');
    }
  }

  @override
  Future<void> addToFavorite(String publicationUuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient.post(
        Uri.parse('http://10.0.2.2:8080/favorites/add/$publicationUuid'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Publication added to favorite list successfully');
    } else if (response.statusCode == 400) {
      // ignore: avoid_print
      print('That publication is already in your favorite list');
    } else {
      throw Exception('Failed to add to favorite');
    }
  }

  @override
  Future<void> removeFavorite(String publicationUuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient.delete(
        Uri.parse('http://10.0.2.2:8080/favorites/remove/$publicationUuid'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Publication removed in favorite list successfully');
    } else if (response.statusCode == 400) {
      // ignore: avoid_print
      print('That publication is not in your favorite list');
    } else {
      throw Exception('Failed to remove favorite');
    }
  }
}
