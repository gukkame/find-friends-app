import 'package:flutter/cupertino.dart';
import 'package:kaquiz/api/general_api.dart';
import 'package:kaquiz/helpers/convert.dart';

class FriendsApi extends GeneralApi {
  Future<Map<String, dynamic>> getFriends(String email) async {
    try {
      return (await readPath(
              collection: "friends", path: Convert.encode(email)))
          .data() as Map<String, dynamic>;
    } catch (e) {
      debugPrint("$e");
      return {};
    }
  }
}
