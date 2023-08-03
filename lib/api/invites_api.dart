import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../utils/user.dart';
import 'general_api.dart';

class InvitesApi extends GeneralApi {
  Future<String?> acceptInvite(User user, String email, String name) async {
    try {
      await update(collection: "friends", path: email, data: {
        "friends.${user.email}": user.name,
        "outbound.${user.email}": FieldValue.delete()
      });
      await update(collection: "friends", path: user.email, data: {
        "friends.$email": name,
        "inbound.$email": FieldValue.delete()
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> declineInvite(User user, String email, String name) async {
    debugPrint("we are ${user.email}");
    debugPrint("we got a friend request from $email");
    try {
      debugPrint("removing $email from ${user.email} inbound");
      await update(
        collection: "friends",
        path: user.email,
        data: {"inbound.$email": FieldValue.delete()},
      );
      debugPrint("removing ${user.email} from $email outbound");
      await update(
        collection: "friends",
        path: email,
        data: {"outbound.${user.email}": FieldValue.delete()},
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
