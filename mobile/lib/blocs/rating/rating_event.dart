part of 'rating_bloc.dart';

@immutable
sealed class RatingEvent {}

class GetRatingDetail extends RatingEvent {
  final String uuidPublicacion;
  GetRatingDetail(this.uuidPublicacion);
}

class RateAPublication extends RatingEvent {
  final String uuidPublicacion;
  final int puntuacion;
  RateAPublication(this.uuidPublicacion, this.puntuacion);
}

class RemoveARating extends RatingEvent {
  final String uuidPublicacion;
  RemoveARating(this.uuidPublicacion);
}

class FetchRatedPosts extends RatingEvent {}
