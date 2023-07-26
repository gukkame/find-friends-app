import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/map.dart';

class Location {
  final String username;
  final double? lat;
  final double? lng;

  Location({
    required this.username,
    this.lat,
    this.lng,
  });

  Marker toMarker(void Function(Location) onMarkerTap) {
    return Marker(
      onTap: () => onMarkerTap(this),
      markerId: MarkerId(username),
      position: LatLng(lat!, lng!),
      infoWindow: InfoWindow(
        title: username,
        // snippet: description,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'lat': lat,
      'lng': lng,
    };
  }
}

Set<Marker> convertUserInfosToMarkers(
    List<Location> UserInfos, void Function(Location) onMarkerTap) {
  final markers = <Marker>{};
  for (var Location in UserInfos) {
    markers.add(Location.toMarker(onMarkerTap));
  }
  return markers;
}
