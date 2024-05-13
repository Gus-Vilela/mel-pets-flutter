import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projeto/pages/home_page.dart';
import 'package:projeto/pages/login_page.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (auth.user == null) {
      return const LoginPage();
    } else {
      log('User: ${auth.user}');
      return const HomePage();
    }
  }
}
