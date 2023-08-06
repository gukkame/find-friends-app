import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../api/locations_api.dart';

class Location {
  final String username;
  double? lat;
  double? lng;
  StreamSubscription<DocumentSnapshot<Object?>>? _updater;

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

  Location setStream(String email) {
    _updater = LocationsApi().getFriendLocationUpdater(email).listen((data) {
      var location = data.data() as Map<String, dynamic>;
      lat = location["lat"] as double;
      lng = location["lng"] as double;
    });
    return this;
  }

  void closeStream() {
    _updater?.cancel();
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
