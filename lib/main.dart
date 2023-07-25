import 'package:flutter/material.dart';
import 'package:kahoot/screens/authentication/login.dart';

import 'screens/authentication/signup.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Markers',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => AddNote(title: 'kahoot'),
        '/signup': (context) => const SignUp(),
        // '/friend-list': (context) => FavoritePage(),
        // '/search': (context) => FavoritePage(),
        // '/invites': (context) => FavoritePage(),
        // '/map': (context) => const Info(
        //       title: '',
        //       about: about,
        //     ),
      },
    );
  }
}
