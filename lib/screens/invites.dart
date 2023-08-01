import 'package:flutter/material.dart';
import 'package:kaquiz/components/user_field.dart';

import '../components/menu_button.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  bool inbound = true;
  bool outbound = false;
  late List<User> inboundUsers;
  late List<User> outboundUsers;
  Widget _infoTextWidget = const SizedBox.shrink();

  void getInboundReq() {
    //!get Inbound rquests from db and save to inboundUsers
  }
  void getOutboundReq() {
    //!get Outbound rquests from db and save to outboundUsers
  }

  void onPressed() {
    setState(() {
      inbound = !inbound;
      outbound = !outbound;
    });
  }

  @override
  void initState() {
    getInboundReq();
    getOutboundReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          _menu,

          ///===========================

          ListView(
            children: [
              if (inbound)
                for (var user in inboundUsers)
                  UserField(
                      type: "Accept",
                      user: user,
                      username: "",
                      email: "",
                      resetState: () => {},
                      setErrorState: _setErrorState)
              else
                for (var user in outboundUsers)
                  UserField(
                      type: "Invited",
                      user: user,
                      username: "",
                      email: "",
                      resetState: () => {},
                      setErrorState: _setErrorState)
            ],
          )
        ],
      ),
    );
  }

  Widget get _menu {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MenuButton(
            title: "Inbound", pressed: inbound, switchButtons: onPressed),
        MenuButton(
            title: "Outbound", pressed: outbound, switchButtons: onPressed),
      ],
    );
  }

  void _setErrorState(String msg) {
    _setInfoWidget(msg);
    setState(() {
      inboundUsers = [];
    });
  }

  void _setInfoWidget(String msg) {
    _infoTextWidget = Center(
        child: Text(
      msg,
      style: const TextStyle(
        color: primeColorTrans,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
