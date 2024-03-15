import 'dart:convert';

import 'package:flutter_application_art/models/dto/publication/create_comment_publication_dto.dart';
import 'package:flutter_application_art/models/dto/publication/create_publication_dto.dart';
import 'package:flutter_application_art/models/response/publication/get_publication_response.dart';
import 'package:flutter_application_art/models/response/publication/publication_detail_response.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicationRepositoryImpl extends PublicationRepository {
  final Client _httpClient = Client();
  @override
  Future<GetPublicationResponse> getPublicationsPaged(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final response = await _httpClient.get(
        Uri.parse('http://10.0.2.2:8080/publications/paged?page=$page'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      return GetPublicationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load publication list');
    }
  }

  @override
  Future<PublicationDetailResponse> getPublicationByUuid(String uuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('token');
    final response = await _httpClient
        .get(Uri.parse('http://10.0.2.2:8080/publication/$uuid'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return PublicationDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load publication');
    }
  }

  @override
  Future<void> createPublication(CreatePublicationDTO dto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/publication/create'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Publication created successfully');
    } else if (response.statusCode == 400) {
      // ignore: avoid_print
      print('The data of the object is invalid');
    } else {
      throw Exception('Failed to create the publication');
    }
  }

  @override
  Future<List<PublicationDetailResponse>> getPublicationsOfUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient
        .get(Uri.parse('http://10.0.2.2:8080/publication/user'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => PublicationDetailResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load publication list');
    }
  }

  @override
  Future<void> editPublication(String uuid, CreatePublicationDTO dto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient.put(
      Uri.parse('http://10.0.2.2:8080/publication/edit/$uuid'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Publication created successfully');
    } else if (response.statusCode == 400) {
      // ignore: avoid_print
      print('The data of the object is invalid');
    } else {
      throw Exception('Failed to create the publication');
    }
  }

  @override
  Future<void> removePublication(String uuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final response = await _httpClient.delete(
        Uri.parse('http://10.0.2.2:8080/publication/remove/$uuid'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 204) {
      // ignore: avoid_print
      print('Publication removed successfully');
    } else {
      throw Exception('Failed to remove favorite');
    }
  }

  @override
  Future<void> createCommentInPublication(
      CreateCommentPublicationDTO dto, String uuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/comment/add/publication/$uuid'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(dto.toJson()),
    );
  }
}
