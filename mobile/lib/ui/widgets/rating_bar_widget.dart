import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/rating/rating_bloc.dart';
import 'package:flutter_application_art/repositories/rating/rating_repository.dart';
import 'package:flutter_application_art/repositories/rating/rating_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatefulWidget {
  final String uuidPublication;
  const RatingBarWidget({Key? key, required this.uuidPublication})
      : super(key: key);

  @override
  State<RatingBarWidget> createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  late RatingRepository ratingRepository;
  late RatingBloc _ratingBloc;
  double valueRate = 0;

  @override
  void initState() {
    super.initState();
    ratingRepository = RatingRepositoryImpl();
    _ratingBloc = RatingBloc(ratingRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ratingBloc,
      child: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          double initialRating = 0;
          if (state is GetRatingSuccess) {
            initialRating = state.response.rating as double;
            print(initialRating);
          }
          if (state is GetRatingNotFound) {
            initialRating = 0;
          }
          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Rate this Publication'),
                    content: Builder(builder: (context) {
                      return RatingBar.builder(
                        initialRating: initialRating,
                        minRating: 0,
                        maxRating: 5,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onRatingUpdate: (rating) {
                          valueRate = rating;
                        },
                      );
                    }),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(color: Colors.white),
                          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.white),
                              backgroundColor:
                                  const Color.fromARGB(255, 19, 114, 138)),
                          child: const Text(
                            'Rate',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _ratingBloc.add(RateAPublication(
                                widget.uuidPublication, valueRate.toInt()));
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                    'You have rated this publication with a ${valueRate.toInt()}'),
                              ),
                            );
                          },
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Delete my rate'),
                        onPressed: () {
                          _ratingBloc
                              .add(RemoveARating(widget.uuidPublication));
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text(
                                  'You have removed your rating from this post'),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Exit'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.star_rounded,
              color: Color.fromARGB(255, 255, 191, 0),
              size: 45,
            ),
          );
        },
      ),
    );
  }
}
