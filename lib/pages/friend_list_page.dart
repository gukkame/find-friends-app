//Display friends, + their city, coordinates(Optional)
//Option to delete friends, send request to DB to delete user

//If nofriends, display, no friends at the moment move to Search page
import 'package:flutter/material.dart';
import 'package:kahoot/screens/friend_list.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Friends List"),
      body: const FriendListScreen(),
      bottomNavigationBar: BottomNavBar(
        index:1 ,
      ),
    );
  }
}
