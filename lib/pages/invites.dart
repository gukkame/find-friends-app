import 'package:flutter/material.dart';

import '../../screens/invites.dart';
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
      appBar: AppBar(title: const Text("Invites")),
      body: const InviteScreen(),
      bottomNavigationBar: const BottomNavBar(
        index: 2,
      ),
    );
  }
}