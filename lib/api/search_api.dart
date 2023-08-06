import 'package:flutter/cupertino.dart';

import '../helpers/convert.dart';
import '../utils/user.dart';
import 'general_api.dart';

class SearchApi extends GeneralApi {
  /// Takes in the current user and the search input. Return
  /// null if the friend request was sent successfully an error message otherwise.
  Future<String?> sendFriendRequest(
      User user, String email, String name) async {
    try {
      await update(
        collection: "friends",
        path: Convert.encrypt(email),
        data: {"inbound.${Convert.encrypt(user.email)}": user.name},
      );
      await update(
          collection: "friends",
          path: Convert.encrypt(user.email),
          data: {"outbound.${Convert.encrypt(email)}": name});
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return "Internal server error.\nPlease contact support.";
    }
  }
}
