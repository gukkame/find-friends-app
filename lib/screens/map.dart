//Get map
//Diplay your location, get your Lat, Long
// Gets friends Lat, Long
// Saves them into markers and diplays on google map

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kahoot/user_location_permission.dart';

import '../helpers/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = const LatLng(59.3530117, 27.4133083);
  List<Place> favLocations = [];
  late GoogleMapController mapController;
  var tappedOnMarker = false;

  var addToFav = false;

  late Place lastTappedMarker = Place(username: 'ds', lat: 58.31, lng: 27.1);
  // final dataStorage = DataStorage();
  CameraPosition camera =
      const CameraPosition(target: LatLng(59.3530117, 27.4133083), zoom: 12);

  void _onMapCreated(GoogleMapController controller) async {
    // favLocations = await dataStorage.getDataFromJSON();
    // setState(() {
    //   favLocations = favLocations;
    // });
    setState(() {
      mapController = controller;
    });
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

  void updateLocation(Place place) {
    setState(() {
      lastTappedMarker = place;
      currentLocation = LatLng(place.lat!, place.lng!);
      tappedOnMarker = true;
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 15.0,
        ),
      ));
    });
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
              // markers: convertPlacesToMarkers(favLocations),
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
                        tappedOnMarker = false;
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
