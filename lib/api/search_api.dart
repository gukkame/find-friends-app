import 'package:flutter/cupertino.dart';

import '../utils/user.dart';
import 'general_api.dart';

class SearchApi extends GeneralApi {
  /// Takes in the current user and the search input. Return
  /// null if the friend request was sent successfully an error message otherwise.
  Future<String?> sendFriendRequest(User user, String input) async {
    try {
      await update(
        collection: "friends",
        path: input,
        data: {
          "inbound": {user.email, user.name},
        },
      );
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return "No user found";
    }
  }
}
