import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';
import '../screens/friend_list.dart';

//Display friends, + their city, coordinates(Optional)
//Option to delete friends, send request to DB to delete user

//If no friends, display, no friends at the moment move to Search page

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  // List<Data> notes = [];
  // List<Data> notes = ProviderManager().getUser(context);

  NoteState state = NoteState.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Friends List", actions: [
        IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              var newState =
                  state != NoteState.delete ? NoteState.delete : NoteState.none;
              setState(() {
                state = newState;
              });
            }),
      ]),
      body: FriendListScreen(state: state),
      bottomNavigationBar: const BottomNavBar(index: 1),
    );
  }
}

enum NoteState { edit, delete, none }
