import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/account/account_bloc.dart';
import 'package:flutter_application_art/blocs/publication/create_comment/create_comment_bloc.dart';
import 'package:flutter_application_art/blocs/publication/publication_detail/publication_detail_bloc.dart';
import 'package:flutter_application_art/repositories/account/account_repository.dart';
import 'package:flutter_application_art/repositories/account/account_repository_impl.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository_impl.dart';
import 'package:flutter_application_art/ui/pages/categories_page.dart';
import 'package:flutter_application_art/ui/widgets/rating_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PublicationDetailPage extends StatefulWidget {
  final String uuid;
  const PublicationDetailPage({Key? key, required this.uuid}) : super(key: key);

  @override
  State<PublicationDetailPage> createState() => _PublicationDetailPageState();
}

class _PublicationDetailPageState extends State<PublicationDetailPage> {
  final _formCreateComment = GlobalKey<FormState>();

  final commentTextController = TextEditingController();
  late PublicationRepository publicationRepository;
  late PublicationDetailBloc _publicationDetailBloc;
  late CreateCommentBloc _createCommentBloc;
  late AccountRepository accountRepository;
  late AccountBloc _accountBloc;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    publicationRepository = PublicationRepositoryImpl();
    accountRepository = AccountRepositoryImpl();
    _publicationDetailBloc = PublicationDetailBloc(publicationRepository)
      ..add(GetPublicationDetail(widget.uuid));
    _accountBloc = AccountBloc(accountRepository);
    _accountBloc.add(GetAccountDetail());

    _accountBloc.stream.listen((accountState) {
      if (accountState is AccountDetailSuccess) {
        setState(() {
          isFavorite = _isPublicationInFavorites(widget.uuid, accountState);
        });
      }
    });
    _createCommentBloc = CreateCommentBloc(publicationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _publicationDetailBloc),
        BlocProvider.value(value: _accountBloc),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, accountState) {
            return BlocBuilder<PublicationDetailBloc, PublicationDetailState>(
              builder: (context, state) {
                if (state is PublicationDetailSuccess) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${state.response.image}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 80
                                : 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 250
                                  : 200,
                              width: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 500
                                  : 500,
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(state.response.lat!),
                                    double.parse(state.response.lon!),
                                  ),
                                  zoom: 14,
                                ),
                                markers: <Marker>{
                                  Marker(
                                    markerId: MarkerId(state.response.titulo!),
                                    position: LatLng(
                                      double.parse(state.response.lat!),
                                      double.parse(state.response.lon!),
                                    ),
                                    infoWindow: InfoWindow(
                                      title: state.response.titulo,
                                      snippet:
                                          '${state.response.nombreMuseo}, ${state.response.direccionObra}',
                                    ),
                                  ),
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: DraggableScrollableSheet(
                              initialChildSize: 0.3,
                              minChildSize: 0.1,
                              maxChildSize: 0.8,
                              expand: true,
                              builder: (context, scrollController) => Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(213, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: ListView(
                                        controller: scrollController,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Center(
                                              child: Text(
                                                'OVERVIEW',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Artist: ${state.response.artista}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Title - ${state.response.titulo}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(height: 10),
                                          Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Size: ${state.response.tamanyoDimensiones}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Location: ${state.response.nombreMuseo}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Street: ${state.response.direccionObra}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const CategoriesPage(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Category: ${state.response.categoria}',
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 20),
                                                Text(
                                                  'Description of the publication: ${state.response.descripcion}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Comments:',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  for (int i = 0;
                                                      i <
                                                          state
                                                              .response
                                                              .comentarios!
                                                              .length;
                                                      i++)
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '${state.response.comentarios?[i].usuario}: ',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '${state.response.comentarios?[i].comment}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  const SizedBox(height: 10),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Create a comment in this publication'),
                                                            content: Builder(
                                                                builder:
                                                                    (context) {
                                                              return Form(
                                                                key:
                                                                    _formCreateComment,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          commentTextController,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(15.0),
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(15.0),
                                                                          ),
                                                                        ),
                                                                        labelText:
                                                                            'Comment',
                                                                        labelStyle: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                0,
                                                                                0)),
                                                                        prefixIcon:
                                                                            Icon(Icons.comment),
                                                                        hintText:
                                                                            'Enter the comment',
                                                                        hintStyle: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                85,
                                                                                85,
                                                                                85)),
                                                                      ),
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Enter a comment that is not empty.';
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Container(
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                20.0),
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (_formCreateComment.currentState!.validate()) {
                                                                              _createCommentBloc.add(CreateComment(commentTextController.text, widget.uuid));
                                                                              Navigator.of(context).pop();
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                const SnackBar(
                                                                                  duration: Duration(seconds: 2),
                                                                                  content: Text('Comment created succesfully!'),
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor: const Color.fromARGB(
                                                                                131,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            foregroundColor:
                                                                                Colors.white,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              side: const BorderSide(color: Colors.white, width: 1.0),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                                                          ),
                                                                          child:
                                                                              const Text(
                                                                            'Create',
                                                                            style:
                                                                                TextStyle(fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          TextButton(
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          textStyle:
                                                                              const TextStyle(color: Colors.black),
                                                                        ),
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0)
                                                            .withOpacity(0.4),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons.comment),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            'Crear comentario',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 20,
                                        left: 30,
                                        child: RatingBarWidget(
                                            uuidPublication: widget.uuid)),
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (state.response.uuid != null) {
                                            if (isFavorite) {
                                              _favoriteOnPressed(
                                                  widget.uuid, accountState);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      seconds: 1,
                                                      milliseconds: 5),
                                                  content: Text(
                                                      'Publication removed from favorite list successfully'),
                                                ),
                                              );
                                              setState(() {
                                                isFavorite = false;
                                              });
                                            } else {
                                              _favoriteOnPressed(
                                                  widget.uuid, accountState);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      seconds: 1,
                                                      milliseconds: 5),
                                                  content: Text(
                                                      'Publication added to favorite list successfully'),
                                                ),
                                              );
                                              setState(() {
                                                isFavorite = true;
                                              });
                                            }
                                          }
                                        },
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorite ? Colors.red : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                } else if (state is PublicationDetailError) {
                  return Text(state.errorMessage);
                } else {
                  return const Center(
                      child: RefreshProgressIndicator(
                    color: Colors.white,
                  ));
                }
              },
            );
          },
        ),
      ),
    );
  }

  bool _isPublicationInFavorites(
      String publicationId, AccountState accountState) {
    if (accountState is AccountDetailSuccess) {
      final userFavorites = accountState.response.favoritos ?? [];
      return userFavorites
          .any((publication) => publication.uuid == publicationId);
    }
    return false;
  }

  void _favoriteOnPressed(String publicationId, AccountState accountState) {
    if (accountState is AccountDetailSuccess) {
      final userFavorites = accountState.response.favoritos ?? [];
      if (userFavorites
          .any((publication) => publication.uuid == publicationId)) {
        _accountBloc.add(RemoveFromFavorite(publicationId));
        setState(() {
          isFavorite = false;
        });
      } else {
        _accountBloc.add(AddToFavorite(publicationId));
        setState(() {
          isFavorite = true;
        });
      }
    }
  }
}
