import 'package:flutter_application_art/models/response/auth/account_detail.dart';
import 'package:flutter_application_art/models/response/rating/rating_response.dart';

abstract class RatingRepository {
  Future<RatingDTO?> getRating(String uuidPublicacion);
  Future<void> rateAPublication(String uuidPublicacion, int valueRating);
  Future<void> deleteARate(String uuidPublicacion);
  Future<List<Publicacion>> getAllPublicationsRated();
}
