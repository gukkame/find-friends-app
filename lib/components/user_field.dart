import 'package:flutter/material.dart';
import '../../api/search_api.dart';
import '../utils/colors.dart';
import '../utils/user.dart';
import 'container.dart';

class UserField extends StatelessWidget {
  final User user;
  final String username;
  final String email;
  final void Function() resetState;
  final void Function(String) setErrorState;

  const UserField({
    super.key,
    required this.user,
    required this.username,
    required this.email,
    required this.resetState,
    required this.setErrorState,
  });

  void _sendFriendRequest() async {
    var resp = await SearchApi().sendFriendRequest(user, email, username);
    if (resp != null) {
      setErrorState("This user is already your friend or\nyou've already sent them a friend request!");
    } else {
      resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedGradientContainer(
      borderSize: 2,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight),
                onPressed: _sendFriendRequest,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: primeGradient,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 11.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
