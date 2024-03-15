import 'package:flutter/material.dart';
import 'package:flutter_application_art/blocs/register/register_bloc.dart';
import 'package:flutter_application_art/repositories/auth/auth_repository.dart';
import 'package:flutter_application_art/repositories/auth/auth_repository_impl.dart';
import 'package:flutter_application_art/ui/pages/home_page.dart';
import 'package:flutter_application_art/ui/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();

  final userTextController = TextEditingController();
  final passTextController = TextEditingController();
  final verifyPassTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final paisTextController = TextEditingController();
  String? passwordValue;

  late AuthRepository authRepository;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    _registerBloc = RegisterBloc(authRepository);
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    verifyPassTextController.dispose();
    emailTextController.dispose();
    nameTextController.dispose();
    paisTextController.dispose();
    _registerBloc.close();
    _formRegister.currentState?.dispose();
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
              value: _registerBloc,
              child: BlocConsumer<RegisterBloc, RegisterState>(
                buildWhen: (context, state) {
                  return state is RegisterInitial ||
                      state is DoRegisterSuccess ||
                      state is DoRegisterError ||
                      state is DoRegisterLoading;
                },
                builder: (context, state) {
                  if (state is DoRegisterSuccess) {
                    return const SizedBox.shrink();
                  } else if (state is DoRegisterError) {
                    return const SizedBox.shrink();
                  } else if (state is DoRegisterLoading) {
                    return const Center(
                        child: RefreshProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                  return Center(child: _buildRegisterForm());
                },
                listener: (BuildContext context, RegisterState state) {
                  if (state is DoRegisterSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                  if (state is DoRegisterError) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
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

  Widget _buildRegisterForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formRegister,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register',
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
              controller: userTextController,
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
                labelText: 'Username',
                labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                prefixIcon: Icon(Icons.person),
                hintText: 'Enter your username',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passTextController,
              obscureText: true,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.password),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                passwordValue = value;
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: verifyPassTextController,
              obscureText: true,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Verify password',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.password),
                hintText: 'Verify your password',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please verify your password';
                }
                if (passwordValue != value) {
                  return 'Password does not match';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.email),
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid email';
                }
                final emailRegex =
                    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address format';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.abc),
                hintText: 'Enter your name',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 4 characters long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: paisTextController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                labelText: 'Country',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.flag),
                hintText: 'Enter your country',
                hintStyle: TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a country';
                }
                if (value.length < 3) {
                  return 'Country must be at least 4 characters long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formRegister.currentState!.validate()) {
                      _registerBloc.add(DoRegisterEvent(
                        userTextController.text,
                        passTextController.text,
                        verifyPassTextController.text,
                        emailTextController.text,
                        nameTextController.text,
                        paisTextController.text,
                      ));
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
                  child: const Text('Register', style: TextStyle(fontSize: 18)),
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
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'Already have an account? Login',
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
