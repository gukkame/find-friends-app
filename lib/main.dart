import 'package:flutter/material.dart';
import 'package:kahoot/pages/authentication/login.dart';
import 'package:kahoot/pages/friend_list_page.dart';
import 'package:kahoot/pages/invites.dart';
import 'package:kahoot/pages/map.dart';
import 'package:kahoot/pages/search.dart';

import 'pages/authentication/signup.dart';

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
      // initialRoute: '/login',
      initialRoute: '/map',
      routes: {
        '/login': (context) => LogIn(title: 'kahoot'),
        '/signup': (context) => SignUp(),
        '/friend-list': (context) => const FriendListPage(),
        '/search': (context) => const SearchPage(),
        '/map': (context) => const MapPage(),
        '/invite': (context) => const InvitePage(),
        // '/invites': (context) => FavoritePage(),
      },
    );
  }
}
