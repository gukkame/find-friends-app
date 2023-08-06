import 'package:flutter/material.dart';

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
      body: MapScreen(),
      bottomNavigationBar: const BottomNavBar(
        index: 0,
      ),
    );
  }
}
