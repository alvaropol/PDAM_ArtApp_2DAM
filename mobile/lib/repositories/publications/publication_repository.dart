import 'package:flutter_application_art/models/dto/publication/create_comment_publication_dto.dart';
import 'package:flutter_application_art/models/dto/publication/create_publication_dto.dart';

import 'package:flutter_application_art/models/response/publication/get_publication_response.dart';
import 'package:flutter_application_art/models/response/publication/publication_detail_response.dart';

abstract class PublicationRepository {
  Future<GetPublicationResponse> getPublicationsPaged(int page);
  Future<PublicationDetailResponse> getPublicationByUuid(String uuid);
  Future<void> createPublication(CreatePublicationDTO dto);
  Future<List<PublicationDetailResponse>> getPublicationsOfUser();
  Future<void> editPublication(String uuid, CreatePublicationDTO dto);
  Future<void> removePublication(String uuid);
  Future<void> createCommentInPublication(
      CreateCommentPublicationDTO dto, String uuid);
}
