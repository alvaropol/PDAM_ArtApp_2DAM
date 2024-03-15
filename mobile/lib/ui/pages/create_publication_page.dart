import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/category/get_category/get_category_bloc.dart';
import 'package:flutter_application_art/blocs/publication/create_publication/create_publication_bloc.dart';
import 'package:flutter_application_art/models/response/category/get_categories_form.dart';
import 'package:flutter_application_art/repositories/categories/category_repository.dart';
import 'package:flutter_application_art/repositories/categories/category_repository_impl.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository.dart';
import 'package:flutter_application_art/repositories/publications/publication_repository_impl.dart';
import 'package:flutter_application_art/ui/pages/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePublicationPage extends StatefulWidget {
  const CreatePublicationPage({super.key});

  @override
  State<CreatePublicationPage> createState() => _CreatePublicationPageState();
}

class _CreatePublicationPageState extends State<CreatePublicationPage> {
  final _formCreatePublication = GlobalKey<FormState>();

  final tituloTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final tamanyoDimensionesTextController = TextEditingController();
  final direccionObraTextController = TextEditingController();
  final nombreMuseoTextController = TextEditingController();
  final latTextController = TextEditingController();
  final lonTextController = TextEditingController();
  final imageTextController = TextEditingController();
  late int selectedCategoryNumber;

  late PublicationRepository publicationRepository;
  late CreatePublicationBloc _createPublicationBloc;
  late CategoryRepository categoryRepository;
  late GetCategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    publicationRepository = PublicationRepositoryImpl();
    _createPublicationBloc = CreatePublicationBloc(publicationRepository);
    categoryRepository = CategoryRepositoryImpl();
    _categoryBloc = GetCategoryBloc(categoryRepository)
      ..add(GetCategoriesFormEvent());
  }

  @override
  void dispose() {
    tituloTextController.dispose();
    descripcionTextController.dispose();
    tamanyoDimensionesTextController.dispose();
    direccionObraTextController.dispose();
    nombreMuseoTextController.dispose();
    latTextController.dispose();
    imageTextController.dispose();

    _createPublicationBloc.close();
    _formCreatePublication.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/fondo_login_register.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocProvider.value(
              value: _createPublicationBloc,
              child:
                  BlocConsumer<CreatePublicationBloc, CreatePublicationState>(
                buildWhen: (context, state) {
                  return state is CreatePublicationInitial ||
                      state is CreatePublicationSuccess ||
                      state is CreatePublicationError ||
                      state is CreatePublicationLoading;
                },
                builder: (context, state) {
                  if (state is CreatePublicationSuccess) {
                    return const SizedBox.shrink();
                  } else if (state is CreatePublicationError) {
                    return const SizedBox.shrink();
                  } else if (state is CreatePublicationLoading) {
                    return const Center(
                        child: RefreshProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                  return Center(child: _buildCreatePublicationForm());
                },
                listener: (BuildContext context, CreatePublicationState state) {
                  if (state is CreatePublicationSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePublicationForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formCreatePublication,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create a publication',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: tituloTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Title',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.title),
                hintText: 'Enter the title of the publication',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.length < 3 || value.length > 31 || value.isEmpty) {
                  return 'Please enter a valid title between 3 and 31 characters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descripcionTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Description',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.description),
                hintText: 'Enter the description of the publication',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: tamanyoDimensionesTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Size of Dimensions',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.photo_size_select_large_sharp),
                hintText: 'Enter the size of dimensions',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the size of dimensions';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: direccionObraTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Work Address',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.location_on),
                hintText: 'Enter the address of the publication',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the address of the publication';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nombreMuseoTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Museum name',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.museum),
                hintText: 'Enter the museun name where is the publication art',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the museum name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: latTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Latitude',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.compare_arrows_outlined),
                hintText: 'Enter the latitude',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the latitude';
                }
                final validLat =
                    RegExp(r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)*$');
                if (!validLat.hasMatch(value)) {
                  return 'Please enter a valid latitude format';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: lonTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Longitude',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.compare_arrows_outlined),
                hintText: 'Enter the longitude',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the longitude';
                }
                final validLon = RegExp(
                    r'^[-+]?(180(\.0+)?|((1[0-7]\d)|(\d{1,2}))(\.\d+)?)$');
                if (!validLon.hasMatch(value)) {
                  return 'Please enter a valid longitude format';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: imageTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Image',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.image),
                hintText: 'Enter the URL of the image',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                final RegExp urlRegex = RegExp(
                    r'^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\+#]*[\w\-@?^=%&/~\+#]$');
                if (!urlRegex.hasMatch(value!)) {
                  return 'Please enter a valid URL of the image';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<GetCategoryBloc, GetCategoryState>(
              bloc: _categoryBloc,
              builder: (context, state) {
                if (state is GetCategoriesFormSuccess) {
                  List<GetCategoriesForm> categories = state.response;
                  categories.insert(
                    0,
                    GetCategoriesForm(nombre: "Without category", numero: -1),
                  );
                  return DropdownButtonFormField<GetCategoriesForm>(
                    items: categories.map((category) {
                      return DropdownMenuItem<GetCategoriesForm>(
                        value: category,
                        child: Text(category.nombre!),
                      );
                    }).toList(),
                    onChanged: (GetCategoriesForm? selectedCategory) {
                      selectedCategoryNumber = selectedCategory!.numero!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Select a category',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formCreatePublication.currentState!.validate()) {
                      _createPublicationBloc.add(CreatePublication(
                        tituloTextController.text,
                        descripcionTextController.text,
                        tamanyoDimensionesTextController.text,
                        direccionObraTextController.text,
                        nombreMuseoTextController.text,
                        latTextController.text,
                        lonTextController.text,
                        imageTextController.text,
                        selectedCategoryNumber,
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('¡Publication created succesfully!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(131, 0, 0, 0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                  ),
                  child: const Text('Create', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text(
                  'Back to the home',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
