import 'package:firebase_auth/firebase_auth.dart';
import '../api/user_api.dart';

class User {
  late UserCredential credential;
  late String email;
  late String name;
  double? lat;
  double? lng;

  Future<String?> signInUser(
      {required String email, required String password}) async {
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      email = email;
      name = await UserApi().getUsername(email: email) as String;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return "Unknown error: ${e.toString()}";
    }
    return null;
  }

  Future<String?> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      email = email;
      name = name;
      await UserApi()
          .registerNewUser(email: email, name: name, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        return 'Invalid email address';
      } else if (e.code == 'operation-not-allowed') {
        return 'Internal server error, please contact support. Error code: ${e.code}';
      }
    } catch (e) {
      return "Unknown error: ${e.toString()}";
    }

    return null;
  }

  User();
}
