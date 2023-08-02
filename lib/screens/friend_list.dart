import 'package:flutter/material.dart';
import '../api/api.dart';
import '../components/user_field.dart';
import '../pages/friend_list_page.dart';
import '../provider/provider_manager.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class FriendListScreen extends StatefulWidget {
  final NoteState state;
  const FriendListScreen({super.key, required this.state});
  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  late User user;
  String errorMSg = "Friends not found!";
  List<MapEntry<String, dynamic>> allFriends = [];

  Future<void> getFriendList() async {
    var allData;
    await Api().readPath(collection: "friends", path: user.email).then((value) {
      setState(() {
        allData = value.data();
      });
    });
    allFriends = allData["friends"].entries.toList();
    print(allData);
  }

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    getFriendList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          if (allFriends.isNotEmpty)
            for (var friend in allFriends)
              UserField(
                  type: "Friend",
                  state: widget.state,
                  user: user,
                  username: friend.value,
                  email: friend.key,
                  resetState: () => {},
                  setErrorState: _setErrorState)
          else
            _setInfoWidget
        ],
      ),
    );
  }

  Widget get _setInfoWidget {
    return Center(
        child: Text(
      errorMSg,
      style: const TextStyle(
        color: primeColorTrans,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
  }

  void _setErrorState(String msg) {
    errorMSg = msg;
  }
}
