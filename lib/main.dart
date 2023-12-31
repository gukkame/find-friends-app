import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaquiz/helpers/convert.dart';
import 'package:provider/provider.dart';

import 'pages/friend_list_page.dart';
import 'pages/invites.dart';
import 'pages/map.dart';
import 'pages/search.dart';
import 'pages/authentication/login.dart';
import 'pages/authentication/signup.dart';
import 'provider/user_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          '/login': (context) => LogIn(),
          '/signup': (context) => SignUp(),
          '/friend-list': (context) => const FriendListPage(),
          '/search': (context) => const SearchPage(),
          '/map': (context) => const MapPage(),
          '/invite': (context) => const InvitePage(),
        },
      ),
    );
  }
}
