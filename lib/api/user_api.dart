import 'api.dart';

class UserApi extends Api {
  Future<bool> checkCredentials(
      {required String email, required String password}) async {
    try {
      await update(
          collection: "users",
          subPath: email,
          subCollection: "private",
          path: email,
          data: {"password": password});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> registerNewUser(
      {required String email,
      required String name,
      required String password}) async {
    try {
      await write(
          collection: "users",
          path: email,
          data: {"email": email, "name": name});
      await write(
          collection: "users",
          path: email,
          subPath: email,
          subCollection: "private",
          data: {"password": password});
      return true;
    } catch (e) {
      return false;
    }
  }
}
