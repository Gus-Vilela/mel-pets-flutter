import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto/app.dart';
import 'package:projeto/firebase_options.dart';
import 'package:projeto/repositories/missing_post_repository.dart';
import 'package:projeto/repositories/pet_repository.dart';
import 'package:projeto/repositories/sighted_repository.dart';
import 'package:projeto/repositories/user_repository.dart';
import 'package:projeto/services/auth.service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(
          create: (context) =>
              PetRepository(authService: context.read<AuthService>())),
      ChangeNotifierProvider(
        create: (context) => MissingPostRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => SightedRepository(),
      ),
      ChangeNotifierProvider(
          create: (context) =>
              UserRepository(authService: context.read<AuthService>())),
    ],
    child: const App(),
  ));
}
