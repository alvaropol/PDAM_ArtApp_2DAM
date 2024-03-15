import 'package:flutter/material.dart';
import 'package:flutter_application_art/ui/pages/publication_detail_page.dart';

class PublicationCardHorizontal extends StatefulWidget {
  final String uuid;
  final String title;
  final String image;
  final int cantidadValoraciones;
  final double? valoracionMedia;
  const PublicationCardHorizontal({
    super.key,
    required this.uuid,
    required this.title,
    required this.image,
    required this.valoracionMedia,
    required this.cantidadValoraciones,
  });

  @override
  State<PublicationCardHorizontal> createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCardHorizontal> {
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
            child: Row(
              children: [
                Expanded(
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
                      const SizedBox(height: 8),
                      if (widget.valoracionMedia != null)
                        _buildRatingStars(widget.valoracionMedia!),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
