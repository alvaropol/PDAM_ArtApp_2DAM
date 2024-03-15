import 'dart:convert';

import 'package:flutter_application_art/models/response/auth/account_detail.dart';
import 'package:flutter_application_art/models/response/rating/rating_response.dart';
import 'package:flutter_application_art/repositories/rating/rating_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingRepositoryImpl extends RatingRepository {
  final Client _httpClient = Client();

  @override
  Future<RatingDTO?> getRating(String uuidPublicacion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await _httpClient.get(
        Uri.parse('http://10.0.2.2:8080/user/rating/$uuidPublicacion'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      return RatingDTO.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load rating response');
    }
  }

  @override
  Future<void> rateAPublication(String uuidPublicacion, int valueRating) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await _httpClient.post(
        Uri.parse(
            'http://10.0.2.2:8080/rate/add/publication/$uuidPublicacion/$valueRating'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Rating added to the publication successfully');
    } else if (response.statusCode == 400) {
      // ignore: avoid_print
      print('Rating value must be between 0 and 5');
    } else {
      throw Exception('Failed to rate the publication');
    }
  }

  @override
  Future<void> deleteARate(String uuidPublicacion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    await _httpClient.delete(
        Uri.parse(
            'http://10.0.2.2:8080/rate/remove/publication/$uuidPublicacion'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
  }

  @override
  Future<List<Publicacion>> getAllPublicationsRated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await _httpClient.get(
      Uri.parse('http://10.0.2.2:8080/user/rating'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Publicacion.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load rating publications');
    }
  }
}
