import 'package:flutter/material.dart';
import 'package:projeto/app.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/sighted_repository.dart';
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
      ChangeNotifierProvider(
        create: (context) => SightedRepository(),
      ),
    ],
    child: const App(),
  ));
}
