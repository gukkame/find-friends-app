import 'package:flutter/material.dart';
import 'package:kahoot/pages/friend_list_page.dart';

class FriendListScreen extends StatefulWidget {
  FriendListScreen({super.key, required NoteState state});
  late NoteState state;
  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  // List<User> notes = [];

  //Map key:value (email:username)
  // List<User> notes = ProviderManager().getUser(context);
  void getFriendList() {
//! Get Friend list from Database
//! Include checker, if there are any changes in database then fetch, if not, then not
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: []),
      ),
    );
  }
}
