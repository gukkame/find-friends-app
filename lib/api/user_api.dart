import 'package:flutter/cupertino.dart';
import 'package:kaquiz/helpers/convert.dart';
import 'general_api.dart';

class UserApi extends GeneralApi {
  Future<bool> registerNewUser(
      {required String email,
      required String name,
      required String password}) async {
    try {
      await write(
        collection: "users",
        path: email,
        data: {"email": Convert.encrypt(email), "name": name},
      );
      await write(
        collection: "friends",
        path: Convert.encrypt(email),
        data: {"friends": {}, "outbound": {}, "inbound": {}},
      );
      await write(
        collection: "locations",
        path: Convert.encrypt(email),
        data: {"lat": 0, "lng": 0},
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
