//Display friends, + their city, coordinates(Optional)
//Option to delete friends, send request to DB to delete user

//If nofriends, display, no friends at the moment move to Search page
import 'package:flutter/material.dart';
import 'package:kahoot/provider/get_provider.dart';
import 'package:kahoot/screens/friend_list.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  // List<Data> notes = [];
  // List<Data> notes = ProviderManager().getUser(context);



  NoteState state = NoteState.None;
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
                  state != NoteState.Delete ? NoteState.Delete : NoteState.None;
              setState(() {
                state = newState;
              });
            }),
      ]),
      body: FriendListScreen(state: state),
      bottomNavigationBar: BottomNavBar(
        index: 1,
      ),
    );
  }
}

enum NoteState { Edit, Delete, None }
