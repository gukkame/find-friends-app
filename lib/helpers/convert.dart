import 'package:encrypt/encrypt.dart';

class Convert {
  static String encrypt(String data) {
    return data.replaceAll(".", ":");
  }

  static String decrypt(String data) {
    return data.replaceAll(":", ".");
  }
}
