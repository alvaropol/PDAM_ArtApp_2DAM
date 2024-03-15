import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/response/auth/account_detail.dart';
import 'package:flutter_application_art/models/response/rating/rating_response.dart';
import 'package:flutter_application_art/repositories/rating/rating_repository.dart';
import 'package:meta/meta.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingRepository ratingRepository;
  RatingBloc(this.ratingRepository) : super(RatingInitial()) {
    on<GetRatingDetail>(_onRatingDetail);
    on<RateAPublication>(_onRateApublication);
    on<RemoveARating>(_onRemoveARating);
    on<FetchRatedPosts>(_onFetchRatedPosts);
  }

  FutureOr<void> _onRatingDetail(
      GetRatingDetail event, Emitter<RatingState> emit) async {
    try {
      final ratingResponse =
          await ratingRepository.getRating(event.uuidPublicacion);
      if (ratingResponse != null) {
        emit(GetRatingSuccess(ratingResponse));
      } else {
        emit(GetRatingNotFound(event.uuidPublicacion));
      }
    } on Exception catch (e) {
      emit(GetRatingError(e.toString()));
    }
  }

  FutureOr<void> _onRateApublication(
      RateAPublication event, Emitter<RatingState> emit) async {
    try {
      await ratingRepository.rateAPublication(
          event.uuidPublicacion, event.puntuacion);
      emit(RateAPublicationSuccess(event.uuidPublicacion));
    } on Exception catch (e) {
      emit(RateAPublicationError(e.toString()));
    }
  }

  FutureOr<void> _onRemoveARating(
      RemoveARating event, Emitter<RatingState> emit) async {
    try {
      await ratingRepository.deleteARate(event.uuidPublicacion);
      emit(RateAPublicationSuccess(event.uuidPublicacion));
    } on Exception catch (e) {
      emit(RateAPublicationError(e.toString()));
    }
  }

  FutureOr<void> _onFetchRatedPosts(
      FetchRatedPosts event, Emitter<RatingState> emit) async {
    final listResponse = await ratingRepository.getAllPublicationsRated();
    emit(RatedPostSuccess(listResponse));
  }
}
