import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/publication/delete_publication/delete_publication_bloc.dart';
import 'package:flutter_application_art/models/dto/publication/create_publication_dto.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository_impl.dart';
import 'package:flutter_application_art/ui/pages/edit_publication_page.dart';
import 'package:flutter_application_art/ui/pages/home_page.dart';
import 'package:flutter_application_art/ui/pages/publication_detail_page.dart';

class PublicationUserCard extends StatefulWidget {
  final String uuid;
  final String title;
  final String image;
  final String descripcion;
  final String tamanyoDimensiones;
  final String direccionObra;
  final String nombreMuseo;
  final String lat;
  final String lon;
  final int cantidadValoraciones;
  final double? valoracionMedia;

  const PublicationUserCard(
      {Key? key,
      required this.uuid,
      required this.title,
      required this.image,
      required this.cantidadValoraciones,
      this.valoracionMedia,
      required this.descripcion,
      required this.tamanyoDimensiones,
      required this.direccionObra,
      required this.nombreMuseo,
      required this.lat,
      required this.lon})
      : super(key: key);

  @override
  State<PublicationUserCard> createState() => _PublicationUserCardState();
}

class _PublicationUserCardState extends State<PublicationUserCard> {
  late PublicationRepository publicationRepository;
  late DeletePublicationBloc _deletePublicationBloc;

  @override
  void initState() {
    super.initState();
    publicationRepository = PublicationRepositoryImpl();
    _deletePublicationBloc = DeletePublicationBloc(publicationRepository);
  }

  Widget _buildRatingStars(double valoracionMedia) {
    List<Widget> stars = [];
    int fullStars = valoracionMedia.floor();
    bool halfStar = valoracionMedia - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber));
    }
    if (halfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber));
    }
    for (int i = stars.length; i < 5; i++) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber));
    }
    stars.add(const SizedBox(width: 4));
    stars.add(Text('(${widget.cantidadValoraciones})'));
    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.valoracionMedia != null)
                  _buildRatingStars(widget.valoracionMedia!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PublicationDetailPage(
                              uuid: widget.uuid,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => EditPublicationPage(
                              dto: CreatePublicationDTO(
                                  titulo: widget.title,
                                  descripcion: widget.descripcion,
                                  tamanyoDimensiones: widget.tamanyoDimensiones,
                                  direccionObra: widget.direccionObra,
                                  nombreMuseo: widget.nombreMuseo,
                                  lat: widget.lat,
                                  lon: widget.lon,
                                  image: widget.image),
                              uuid: widget.uuid,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure to delete this post?'),
                              content: Builder(builder: (context) {
                                return const Text(
                                    'By deleting this post it will be permanently lost.');
                              }),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle:
                                          const TextStyle(color: Colors.white),
                                      backgroundColor: const Color.fromARGB(
                                          255, 187, 56, 56),
                                    ),
                                    child: const Text(
                                      'Eliminar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _deletePublicationBloc
                                          .add(DeletePublication(widget.uuid));
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text(
                                              '¡Publication removed succesfully!'),
                                        ),
                                      );
                                    }),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        const TextStyle(color: Colors.black),
                                  ),
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
