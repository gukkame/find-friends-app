import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaquiz/api/general_api.dart';
import 'package:kaquiz/helpers/convert.dart';

import '../utils/user.dart';

class FriendsApi extends GeneralApi {
  Future<Map<String, dynamic>> getFriends(String email) async {
    try {
      var data =
          (await readPath(collection: "friends", path: Convert.encode(email)))
              .data() as Map<String, dynamic>;

      Map<String, Map<String, String>> friends = {};
      for (var field in data.entries) {
        Map<String, String> fieldValue = {};
        for (var entry in field.value.entries) {
          fieldValue[Convert.decode(entry.key)] = entry.value as String;
        }
        friends[field.key] = fieldValue;
      }
      return friends;
    } catch (e) {
      debugPrint("$e");
      return {};
    }
  }

  Future<String?> removeFriend(User user, String email) async {
    try {
      await update(
        collection: "friends",
        path: Convert.encode(user.email),
        data: {"friends.${Convert.encode(email)}" : FieldValue.delete()},
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
