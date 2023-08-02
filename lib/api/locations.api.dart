import '../utils/user.dart';
import 'general_api.dart';

class LocationsApi extends GeneralApi {
  /// Updates the position of the current user.
  /// Returns null if the update was successful.
  /// Returns the error message otherwise.
  Future<String?> updatePosition(
      {required String email, required int lat, required int lng}) async {
    try {
      await update(
        collection: "locations",
        path: email,
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
  Stream getFriendLocationUpdater(String email) {
    return getStream(collection: "locations", path: email);
  }
}
