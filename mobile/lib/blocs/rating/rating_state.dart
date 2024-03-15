part of 'rating_bloc.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

final class GetRatingSuccess extends RatingState {
  final RatingDTO response;
  GetRatingSuccess(this.response);
}

final class GetRatingNotFound extends RatingState {
  final String uuidPublication;
  GetRatingNotFound(this.uuidPublication);
}

final class GetRatingError extends RatingState {
  final String errorMessage;
  GetRatingError(this.errorMessage);
}

final class RateAPublicationSuccess extends RatingState {
  final String publicationUuid;
  RateAPublicationSuccess(this.publicationUuid);
}

final class RateAPublicationError extends RatingState {
  final String errorMessage;
  RateAPublicationError(this.errorMessage);
}

final class RemoveARatingSuccess extends RatingState {
  final String publicationUuid;
  RemoveARatingSuccess(this.publicationUuid);
}

final class RemoveARatingError extends RatingState {
  final String errorMessage;
  RemoveARatingError(this.errorMessage);
}

final class RatedPostSuccess extends RatingState {
  final List<Publicacion> response;
  RatedPostSuccess(this.response);
}
