import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/publication/get_publication/get_publication_bloc.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository_impl.dart';
import 'package:flutter_application_art/ui/widgets/publication_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePublicationsPage extends StatefulWidget {
  const HomePublicationsPage({Key? key}) : super(key: key);

  @override
  State<HomePublicationsPage> createState() => _HomePublicationsPageState();
}

class _HomePublicationsPageState extends State<HomePublicationsPage> {
  late PublicationRepository publicationRepository;
  late GetPublicationBloc _publicationBloc;

  @override
  void initState() {
    super.initState();
    publicationRepository = PublicationRepositoryImpl();
    _publicationBloc = GetPublicationBloc(publicationRepository)
      ..add(GetPublicationList(0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _publicationBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: _publicationList(),
      ),
    );
  }

  Widget _pageNavigationButtons() {
    return BlocBuilder<GetPublicationBloc, GetPublicationState>(
      builder: (context, state) {
        if (state is GetPublicationSuccess) {
          final int totalPages = state.response.totalPages ?? 0;
          final int currentPage = state.response.pageable?.pageNumber ?? 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentPage > 0)
                ElevatedButton(
                  onPressed: () {
                    if (currentPage > 0) {
                      setState(() {
                        _publicationBloc
                            .add(GetPublicationList(currentPage - 1));
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    'Previous',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              const SizedBox(width: 10),
              Text(
                'Page ${currentPage + 1} of $totalPages',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 10),
              if (currentPage < totalPages - 1)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _publicationBloc.add(GetPublicationList(currentPage + 1));
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _publicationList() {
    return Column(
      children: [
        _pageNavigationButtons(),
        Expanded(
          child: BlocBuilder<GetPublicationBloc, GetPublicationState>(
            builder: (context, state) {
              if (state is GetPublicationSuccess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: state.response.content?.length,
                  itemBuilder: (context, index) {
                    String image = "${state.response.content?[index].image}";
                    String title = "${state.response.content?[index].titulo}";
                    String uuid = "${state.response.content?[index].uuid}";
                    int? cantidadValoraciones =
                        state.response.content![index].cantidadValoraciones;
                    String category =
                        "${state.response.content?[index].categoria}";
                    double? valoracionMedia =
                        state.response.content?[index].valoracionMedia;
                    return Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: PublicationCard(
                        uuid: uuid,
                        title: title,
                        image: image,
                        category: category,
                        cantidadValoraciones: cantidadValoraciones,
                        valoracionMedia: valoracionMedia,
                      ),
                    );
                  },
                );
              } else if (state is GetPublicationError) {
                return Text(state.errorMessage);
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
