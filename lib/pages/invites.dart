import 'package:flutter/material.dart';
import 'package:kahoot/screens/invites.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Friends List"),
      body: InviteScreen(),
      bottomNavigationBar: BottomNavBar(
        index: 2,
      ),
    );
  }
}
