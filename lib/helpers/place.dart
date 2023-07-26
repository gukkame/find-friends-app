import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String username;
  final double? lat;
  final double? lng;

  Place({
    required this.username,
    this.lat,
    this.lng,
  });

  Marker toMarker() {
    return Marker(
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

Set<Marker> convertPlacesToMarkers(List<Place> places) {
  final markers = <Marker>{};
  for (var place in places) {
    markers.add(place.toMarker());
  }
  return markers;
}
