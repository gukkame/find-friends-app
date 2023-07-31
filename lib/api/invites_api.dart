import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kahoot/api/general_api.dart';

import '../utils/user.dart';

class InvitesApi extends GeneralApi {
  Future<String?> acceptInvite(User user, String email, String name) async {
    try {
      await update(collection: "friends", path: email, data: {
        "friends": {user.email: user.name},
        "outbound": {user.email: FieldValue.delete()}
      });
      await update(collection: "friends", path: user.email, data: {
        "friends": {email: name},
        "inbound": {email: FieldValue.delete()}
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> declineInvite(User user, String email, String name) async {
    try {
      await update(collection: "friends", path: email, data: {
        "outbound": {user.email: FieldValue.delete()}
      });
      await update(collection: "friends", path: user.email, data: {
        "inbound": {email: FieldValue.delete()}
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
