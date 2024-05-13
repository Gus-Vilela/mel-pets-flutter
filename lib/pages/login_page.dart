import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto/pages/register_page.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoading = false;

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await context.read<AuthService>().login(email.text, password.text);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text('Login',
            style: TextStyle(color: Colors.black87),
            textAlign: TextAlign.center),
      ),
      body: Padding(
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
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
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
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller:
                          password, // replace with your password controller
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Password', // replace with your label text
                        labelStyle: const TextStyle(
                            color: Colors.black87, fontSize: 18),
                        errorStyle: const TextStyle(color: Colors.red),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : login,
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
                                      'Entrando...',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 18),
                                    ),
                                  ),
                                ],
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.black87,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Text(
                                      'Entrar',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Novo por aqui? Cadastre-se',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
