import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';
import 'screens/authentication/login.dart';
import 'screens/authentication/signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
import 'package:kahoot/screens/authentication/login.dart';

import 'screens/authentication/signup.dart';

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserDataProvider(),
      child: MaterialApp(
        title: 'Map Markers',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LogIn(title: 'kahoot'),
          '/signup': (context) => SignUp(),
          // '/friend-list': (context) => FavoritePage(),
          // '/search': (context) => FavoritePage(),
          // '/invites': (context) => FavoritePage(),
          // '/map': (context) => const Info(
          //       title: '',
          //       about: about,
          //     ),
        },
      ),
    );
  }
}
