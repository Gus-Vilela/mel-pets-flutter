import 'package:flutter/material.dart';
import 'package:projeto/widget/auth_check.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mel Pets',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthCheck(),
    );
  }
}
