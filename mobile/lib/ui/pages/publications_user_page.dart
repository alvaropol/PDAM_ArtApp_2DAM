import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/publication/get_publication_user/get_publication_user_bloc.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository_impl.dart';
import 'package:flutter_application_art/ui/widgets/publication_user_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicationsUserPage extends StatefulWidget {
  const PublicationsUserPage({super.key});

  @override
  State<PublicationsUserPage> createState() => _PublicationsUserPageState();
}

class _PublicationsUserPageState extends State<PublicationsUserPage> {
  late PublicationRepository publicationRepository;
  late GetPublicationUserBloc _publicationBloc;

  @override
  void initState() {
    super.initState();
    publicationRepository = PublicationRepositoryImpl();
    _publicationBloc = GetPublicationUserBloc(publicationRepository)
      ..add(GetPublicationsUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _publicationBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your publications',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: _publicationList(),
      ),
    );
  }

  Widget _publicationList() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<GetPublicationUserBloc, GetPublicationUserState>(
            builder: (context, state) {
              if (state is GetPublicationUserSuccess) {
                if (state.response.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'You have not posted anything yet',
                      style: TextStyle(fontSize: 40),
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: state.response.length,
                    itemBuilder: (context, index) {
                      String image = "${state.response[index].image}";
                      String title = "${state.response[index].titulo}";
                      String uuid = "${state.response[index].uuid}";
                      String descripcion =
                          "${state.response[index].descripcion}";
                      String tamanyoDimensiones =
                          "${state.response[index].tamanyoDimensiones}";
                      String direccionObra =
                          "${state.response[index].direccionObra}";
                      String nombreMuseo =
                          "${state.response[index].nombreMuseo}";
                      String lat = "${state.response[index].lat}";
                      String lon = "${state.response[index].lon}";
                      int? cantidadValoraciones =
                          state.response[index].cantidadValoraciones!;
                      double? valoracionMedia =
                          state.response[index].valoracionMedia;
                      return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: PublicationUserCard(
                            uuid: uuid,
                            title: title,
                            image: image,
                            descripcion: descripcion,
                            tamanyoDimensiones: tamanyoDimensiones,
                            direccionObra: direccionObra,
                            nombreMuseo: nombreMuseo,
                            lat: lat,
                            lon: lon,
                            cantidadValoraciones: cantidadValoraciones,
                            valoracionMedia: valoracionMedia),
                      );
                    },
                  );
                }
              } else if (state is GetPublicationUserError) {
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
