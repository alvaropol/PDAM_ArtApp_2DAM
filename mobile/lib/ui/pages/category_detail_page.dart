import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/category/category_detail/category_detail_bloc.dart';
import 'package:flutter_application_art/repositories/categories/category_repository.dart';
import 'package:flutter_application_art/repositories/categories/category_repository_impl.dart';
import 'package:flutter_application_art/ui/widgets/publication_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailPage extends StatefulWidget {
  final String uuid;
  final String name;
  const CategoryDetailPage({super.key, required this.uuid, required this.name});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late CategoryRepository categoryRepository;
  late CategoryDetailBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryRepository = CategoryRepositoryImpl();
    _categoryBloc = CategoryDetailBloc(categoryRepository)
      ..add(GetCategoryDetail(widget.uuid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _categoryBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
          child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
            builder: (context, state) {
              if (state is CategoryDetailSuccess) {
                if (state.response.publicaciones!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'No publications in this category',
                      style: TextStyle(fontSize: 40),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: state.response.publicaciones?.length,
                  itemBuilder: (context, index) {
                    String image =
                        "${state.response.publicaciones?[index].image}";
                    String title =
                        "${state.response.publicaciones?[index].titulo}";
                    String uuid =
                        "${state.response.publicaciones?[index].uuid}";
                    int? cantidadValoraciones = state
                        .response.publicaciones?[index].cantidadValoraciones;
                    double? valoracionMedia =
                        state.response.publicaciones?[index].valoracionMedia;
                    return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: PublicationCard(
                          uuid: uuid,
                          title: title,
                          image: image,
                          cantidadValoraciones: cantidadValoraciones,
                          valoracionMedia: valoracionMedia,
                          category: widget.name,
                        ));
                  },
                );
              } else if (state is CategoryDetailError) {
                return Text(state.errorMessage);
              } else {
                return const RefreshProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
