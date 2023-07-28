import 'package:flutter/material.dart';
import 'package:kahoot/api/user_api.dart';
import 'package:kahoot/provider/get_provider.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  Widget _friendsView(Map<String, dynamic> data) {
    if (data.isEmpty) {
      return const Text("Nothing here yet.\nGo make some friends! :D");
    } else {
      return Column(
        children: _createFriendsViewWidgets(data),
      );
    }
  }

  List<Widget> _createFriendsViewWidgets(Map<String, dynamic> data) {
    List<Widget> friends = [];
    for (var obj in data.entries) {
      friends.add(Text("${obj.key} : ${obj.value}"));
    }
    return friends;
  }

  Widget get _errorMessage {
    return const Text("Internal server error.\nPlease contact support.");
  }

  Widget get _loading {
    return const Text("Loading...");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserApi().getFriends(ProviderManager().getUser(context)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loading;
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          debugPrint("${snapshot.error}");
          return _errorMessage;
        }
        return _friendsView(snapshot.data as Map<String, dynamic>);
      },
    );
  }
}
