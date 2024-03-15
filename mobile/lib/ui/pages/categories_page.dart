import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/category/get_category/get_category_bloc.dart';
import 'package:flutter_application_art/repositories/categories/category_repository.dart';
import 'package:flutter_application_art/repositories/categories/category_repository_impl.dart';
import 'package:flutter_application_art/ui/widgets/category_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int page = 1; // Comenzamos desde la página 1
  late CategoryRepository _categoryRepository;
  late GetCategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryRepository = CategoryRepositoryImpl();
    _categoryBloc = GetCategoryBloc(_categoryRepository)
      ..add(GetCategoryList(page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _categoryBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: _buildCategoryList(),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Column(
      children: [
        _pageNavigationButtons(),
        Expanded(
          child: BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategorySuccess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: state.response.content?.length,
                  itemBuilder: (context, index) {
                    String image = "${state.response.content?[index].image}";
                    String title = "${state.response.content?[index].nombre}";
                    String uuid = "${state.response.content?[index].uuid}";
                    int cantidadPublicaciones =
                        state.response.content![index].publicaciones!.length;
                    return Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CategoryCard(
                        uuid: uuid,
                        title: title,
                        image: image,
                        cantidadPublicaciones: cantidadPublicaciones,
                      ),
                    );
                  },
                );
              } else if (state is GetCategoryError) {
                return Center(
                  child: Text(state.errorMessage),
                );
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

  Widget _pageNavigationButtons() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategorySuccess) {
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
                        page = currentPage - 1;
                        _categoryBloc.add(GetCategoryList(page));
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
                    if (currentPage < totalPages - 1) {
                      setState(() {
                        page = currentPage + 1;
                        _categoryBloc.add(GetCategoryList(page));
                      });
                    }
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
}
