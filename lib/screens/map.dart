//Get map
//Diplay your location, get your Lat, Long
// Gets friends Lat, Long
// Saves them into markers and diplays on google map

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kahoot/helpers/userInfo.dart';
import 'package:kahoot/user_location_permission.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  set tappedMarker2(bool tappedMarker2) {}

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = const LatLng(59.3530117, 27.4133083);
  //! Locations of friends
  List<Location> favLocations = [
    Location(username: "ajjjj", lat: 59.31, lng: 27.1)
  ];
  late GoogleMapController mapController;
  var tappedOnMarker = false;

  // set tappedMarker2(bool isTapped) => tappedOnMarker;

  void test() {
    print(" dw;");
  }

  var addToFav = false;

  late Location lastTappedMarker =
      Location(username: 'ds', lat: 58.31, lng: 27.1);

  CameraPosition camera =
      const CameraPosition(target: LatLng(59.3530117, 27.4133083), zoom: 12);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    print("onmapcreated");
    setState(() {});
  }

  // Future<void> _onTapMap(LatLng latLng) async {
  //   final mapData = MapData();

  //   lastTappedMarker = await mapData.getTapLocation(latLng);

  //   setState(() {
  //     addToFav = false;
  //     icon = Icon(Icons.favorite_border);

  //     lastTappedMarker = lastTappedMarker;
  //     tappedOnMarker = true;
  //   });
  // }

  void updateLocation(Location Location) {
    setState(() {
      lastTappedMarker = Location;
      currentLocation = LatLng(Location.lat!, Location.lng!);
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
    return print(" Marker Pressed :)");
  }

  Set<Marker> getMarkers() {
    var markers = convertUserInfosToMarkers(favLocations, markerPressed);
    return markers;
  }

  @override
  void initState() {
    final userPerm = UserLocation();
    userPerm.getUserCurrentLocation().then((value) {
      setState(() {
        currentLocation = LatLng(value.latitude, value.longitude);
        print(currentLocation);
      });
    });
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
