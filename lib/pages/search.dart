
//Search page, where users can search other users and see if anyone has invited them.
//People are displayed in the list with buttons on side, accept/deny or send friend request

//Search by email
import 'package:flutter/material.dart';
import 'package:kahoot/screens/search.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "Search"),
      body: const SearchScreen(),
      bottomNavigationBar: BottomNavBar(
        index: 3,
      ),
    );
  }
}