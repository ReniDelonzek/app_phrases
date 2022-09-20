import 'package:app_phrases/core/di/injection_container.dart';
import 'package:app_phrases/domain/repositories/auth_repository.dart';
import 'package:app_phrases/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isLogged = await get.get<AuthRepository>().isLogged();
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.red),
    home: isLogged ? const HomePage() : const LoginPage(),
  ));
}
