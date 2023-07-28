import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    List<Location> userInfos, void Function(Location) onMarkerTap) {
  final markers = <Marker>{};
  for (var location in userInfos) {
    markers.add(location.toMarker(onMarkerTap));
  }
  return markers;
}
