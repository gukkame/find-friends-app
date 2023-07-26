import 'api.dart';

class UserApi extends Api {
  Future<bool> registerNewUser(
      {
      required String email,
      required String name,
      required String password}) async {
    try {
      await write(
          collection: "users",
          path: email,
          data: {"email": email, "name": name});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getUsername({required String email}) async {
    try {
      var resp = await readPath(collection: "users", path: email);
      return (resp as Map<String, dynamic>)["name"] as String;
    } catch (e) {
      return null;
    }
  }
}
