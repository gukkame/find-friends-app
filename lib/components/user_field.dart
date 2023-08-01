import 'package:flutter/material.dart';
import '../../api/search_api.dart';
import '../api/invites_api.dart';
import '../utils/colors.dart';
import '../utils/user.dart';
import 'container.dart';

class UserField extends StatelessWidget {
  final String type;
  final User user;
  final String username;
  final String email;
  final void Function() resetState;
  final void Function(String) setErrorState;

  const UserField({
    super.key,
    required this.type,
    required this.user,
    required this.username,
    required this.email,
    required this.resetState,
    required this.setErrorState,
  });

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
              _button
            ],
          )),
    );
  }

  void _acceptFriendRequest() async {
    var resp = await InvitesApi().acceptInvite(user, email, username);
      print("Invite accepted1");
    if (resp != null) {
         print("Invite accepted2");
      setErrorState("You already accepted friend request!");
    } else {
      print("Invite accepted3");
      resetState();
    }
  }

  void _declineFriendRequest() async {
    var resp = await InvitesApi().declineInvite(user, email, username);
      print("Invite declined");
    if (resp != null) {
      setErrorState("Cant decline friend request");
    } else {
        print("Invite declined");
      resetState();
    }
  }

  void _sendFriendRequest() async {
    var resp = await SearchApi().sendFriendRequest(user, email, username);
    if (resp != null) {
      setErrorState(
          "This user is already your friend or\nyou've already sent them a friend request!");
    } else {
      resetState();
    }
  }

  Widget get _acceptBtn {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerRight),
      onPressed: _acceptFriendRequest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 11.0),
        child: Text(
          "Accept",
          style: TextStyle(
              color: primeColor.withOpacity(0.9),
              fontWeight: FontWeight.bold,
              fontSize: 14.0),
        ),
      ),
    );
  }

  Widget get _declineBtn {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerRight),
      onPressed: _declineFriendRequest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 11.0),
        child: Text(
          "Decline",
          style: TextStyle(
              color: primeColor.withOpacity(0.9),
              fontWeight: FontWeight.bold,
              fontSize: 14.0),
        ),
      ),
    );
  }

  Widget get _button {
    var action;
    String title = "";
    if (type == "Add") {
      action = _sendFriendRequest;
      title = "Add";
    } else if (type == "Outbound") {
      title = "Invited";
    } else if (type == "Inbound") {
      return Row(
        children: [
          _declineBtn,
          _acceptBtn,
        ],
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerRight),
      onPressed: action,
      child: Container(
        decoration: type == "Outbound"
            ? BoxDecoration(
                color: primeColorTrans,
                borderRadius: BorderRadius.circular(12.0),
              )
            : BoxDecoration(
                gradient: primeGradient,
                borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 11.0),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
