import 'package:flutter/cupertino.dart';

import 'api.dart';

class UserApi extends Api {
  Future<bool> registerNewUser(
      {required String email,
      required String name,
      required String password}) async {
    try {
      await write(
        collection: "users",
        path: email,
        data: {"email": email, "name": name},
      );
      await write(
        collection: "friends",
        path: email,
        data: {"friends": {}, "outbound": {}, "inbound": {}},
      );
      await write(
        collection: "locations",
        path: email,
        data: {"lat": 0, "lng": 0},
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<String?> getUsername({required String email}) async {
    try {
      var resp = await readPath(collection: "users", path: email);
      debugPrint("get the doc: ${resp.data()}");
      return (resp.data() as Map<String, dynamic>)["name"] as String;
    } catch (e) {
      return null;
    }
  }
}
