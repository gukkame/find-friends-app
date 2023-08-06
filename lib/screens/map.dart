//Get map
//Display your location, get your Lat, Long
// Gets friends Lat, Long
// Saves them into markers and displays on google map

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kaquiz/api/friends_api.dart';
import '../../api/locations_api.dart';

import '../helpers/location.dart';
import '../provider/provider_manager.dart';
import '../user_location_permission.dart';
import '../utils/user.dart';

class MapScreen extends StatefulWidget {
  final LocationsApi api = LocationsApi();
  MapScreen({super.key});

  set tappedMarker2(bool tappedMarker2) {}

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late User user;
  LatLng currentLocation = const LatLng(59.3530117, 27.4133083);
  List<Location> locations = [];
  late GoogleMapController mapController;
  var tappedOnMarker = false;
  var addToFav = false;
  late Location lastTappedMarker =
      Location(username: 'ds', lat: 58.31, lng: 27.1);
  CameraPosition camera =
      const CameraPosition(target: LatLng(59.3530117, 27.4133083), zoom: 12);
  late Timer timer;

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    final userPerm = UserLocation();

    userPerm.getUserCurrentLocation().then((value) {
      currentLocation = LatLng(value.latitude, value.longitude);
      debugPrint("$currentLocation");
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        debugPrint("self updating position");
        widget.api.updatePosition(
          user: user,
          lat: currentLocation.latitude,
          lng: currentLocation.longitude,
        );
        setState(() {});
      });
      setFriendLocationListeners();
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    for (var location in locations) {
      location.closeStream();
    }
    super.dispose();
  }

  Future<void> setFriendLocationListeners() async {
    var friends = await FriendsApi().getFriends(user);
    for (var friend in (friends["friends"] as Map<String, String>).entries) {
      locations.add(Location(username: friend.value).setStream(friend.key));
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    debugPrint("On Map Create");
    setState(() {});
  }

  void updateLocation(Location location) {
    setState(() {
      lastTappedMarker = location;
      currentLocation = LatLng(location.lat!, location.lng!);
      tappedOnMarker = true;
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 15.0,
        ),
      ));
    });
  }

  void markerPressed(Location location) {
    setState(() {
      tappedOnMarker = true;
      lastTappedMarker = location;
    });
    return debugPrint(" Marker Pressed :)");
  }

  Set<Marker> getMarkers() {
    var markers = convertUserInfosToMarkers(locations, markerPressed);
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: camera,
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              markers: getMarkers(),
            ),
          ),
          Positioned(
              child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: tappedOnMarker ? 100 : 0,
            decoration: const BoxDecoration(color: Colors.white30),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (tappedOnMarker == true) Text(lastTappedMarker.username),
                  ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          tappedOnMarker = false;
                        });
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(''))
                ]),
          ))
        ],
      ),
    );
  }
}
