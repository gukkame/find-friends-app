
//Display map with friend locations on the map

import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';
import '../screens/map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      // appBar:  CustomAppBar(title: "Friends List"),
      body: MapScreen(),
      bottomNavigationBar: BottomNavBar(
        index: 0,
      ),
    );
  }
}