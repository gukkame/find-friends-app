import 'package:flutter/material.dart';
import 'package:kaquiz/api/friends_api.dart';
import '../components/user_field.dart';
import '../pages/friend_list_page.dart';
import '../provider/provider_manager.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class FriendListScreen extends StatefulWidget {
  final FriendsApi api = FriendsApi();
  final NoteState state;
  FriendListScreen({super.key, required this.state});
  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  late User user;
  String errorMSg = "Friends not found!";
  List<MapEntry<String, dynamic>> allFriends = [];

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    getFriendList();
    super.initState();
  }

  Future<void> getFriendList() async {
    var allData = await widget.api.getFriends(user.email);
    allFriends = allData.containsKey("friends")
        ? (allData["friends"] as Map<String, dynamic>).entries.toList()
        : allFriends;
    setState(() {});
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
}
