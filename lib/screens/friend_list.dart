import 'package:flutter/material.dart';
import '../pages/friend_list_page.dart';

class FriendListScreen extends StatefulWidget {
  final NoteState state;
  const FriendListScreen({super.key, required this.state});
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(children: const []),
    );
  }
}
