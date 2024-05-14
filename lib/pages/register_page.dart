import 'package:flutter/material.dart';
import 'package:projeto/models/user.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  late UserRepository userRepository;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    userRepository = context.watch<UserRepository>();

    register() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        try {
          await context.read<AuthService>().register(
                email.text,
                password.text,
              );

          var user = User(
            id: context.read<AuthService>().user!.uid,
            email: email.text,
            name: name.text,
          );

          await userRepository.addUser(user);
          Navigator.pop(context);
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Registrar',
            style: TextStyle(color: Colors.black87),
            textAlign: TextAlign.center),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                          errorStyle: const TextStyle(color: Colors.red),
                          // selected style
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]!),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                          errorStyle: const TextStyle(color: Colors.red),
                          // selected style
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]!),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um email';
                          }
                          if (!value.contains('@')) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                          errorStyle: const TextStyle(color: Colors.red),
                          // selected style
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]!),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: confirmPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha',
                          labelStyle: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                          errorStyle: const TextStyle(color: Colors.red),
                          // selected style
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]!),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirme a senha';
                          }
                          if (value != password.text) {
                            return 'As senhas não coincidem';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.black87),
                                      backgroundColor: Colors.red[100],
                                      strokeWidth: 2,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Text(
                                        'Registrando',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      color: Colors.black87,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Text(
                                        'Registrar',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
