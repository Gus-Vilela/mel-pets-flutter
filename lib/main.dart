import 'package:flutter/material.dart';
import 'package:projeto/app.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PetRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => MissingPostRepository(),
      ),
      // add more providers as needed
    ],
    child: const App(),
  ));
}
