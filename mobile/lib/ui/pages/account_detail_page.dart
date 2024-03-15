import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/account/account_bloc.dart';
import 'package:flutter_application_art/blocs/rating/rating_bloc.dart';
import 'package:flutter_application_art/models/response/auth/account_detail.dart';
import 'package:flutter_application_art/repositories/account/account_repository.dart';
import 'package:flutter_application_art/repositories/account/account_repository_impl.dart';
import 'package:flutter_application_art/repositories/rating/rating_repository.dart';
import 'package:flutter_application_art/repositories/rating/rating_repository_impl.dart';
import 'package:flutter_application_art/ui/pages/login_page.dart';
import 'package:flutter_application_art/ui/widgets/publication_horizontal_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({Key? key}) : super(key: key);

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  late AccountRepository accountRepository;
  late AccountBloc _accountBloc;
  late RatingBloc _ratingBloc;
  late RatingRepository ratingRepository;

  @override
  void initState() {
    super.initState();
    accountRepository = AccountRepositoryImpl();
    _accountBloc = AccountBloc(accountRepository)..add(GetAccountDetail());

    ratingRepository = RatingRepositoryImpl();
    _ratingBloc = RatingBloc(ratingRepository)..add(FetchRatedPosts());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _accountBloc),
        BlocProvider.value(value: _ratingBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your profile',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, accountState) {
            if (accountState is AccountDetailSuccess) {
              final response = accountState.response;
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileInfo(response),
                      const SizedBox(height: 20),
                      _buildHorizontalList(
                        icon: Icons.favorite,
                        title: 'Favorite posts',
                        publications: response.favoritos ?? [],
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<RatingBloc, RatingState>(
                        builder: (context, ratingState) {
                          if (ratingState is RatedPostSuccess) {
                            final publications = ratingState.response;
                            return _buildHorizontalList(
                              icon: Icons.star,
                              title: 'Rated posts',
                              publications: publications,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (accountState is AccountDetailError) {
              return Text(accountState.errorMessage);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileInfo(AccountDetailResponse response) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/6/67/User_Avatar.png',
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                response.nombre!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                'Username: ${response.username}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 126, 126, 126),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Country: ${response.pais}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 126, 126, 126),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Since: ${response.createdAt}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 146, 146, 146),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 182, 186, 189),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalList({
    required IconData icon,
    required String title,
    required List<Publicacion> publications,
  }) {
    if (publications.isEmpty) {
      return Text(
        'No $title added',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: icon == Icons.favorite ? Colors.red : Colors.yellow,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: publications.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PublicationCardHorizontal(
                      uuid: publications[index].uuid!,
                      title: publications[index].titulo!,
                      image: publications[index].image!,
                      cantidadValoraciones:
                          publications[index].cantidadValoraciones!,
                      valoracionMedia: publications[index].valoracionMedia!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
