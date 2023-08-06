import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/convert.dart';
import '../utils/user.dart';
import 'general_api.dart';

class LocationsApi extends GeneralApi {
  /// Updates the position of the current user.
  /// Returns null if the update was successful.
  /// Returns the error message otherwise.
  Future<String?> updatePosition(
      {required User user, required double lat, required double lng}) async {
    try {
      await update(
        collection: "locations",
        path: Convert.encode(user.email),
        data: {
          "lat": lat,
          "lng": lng,
        },
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Sets up a listener to the database document.
  /// When the user at the given email updates their position,
  /// the stream will fire and give their new coordinates
  Stream<DocumentSnapshot<Object?>> getFriendLocationUpdater(String email) {
    return getStream(collection: "locations", path: Convert.encode(email));
  }
}
