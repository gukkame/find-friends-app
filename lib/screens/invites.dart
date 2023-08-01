import 'package:flutter/material.dart';
import 'package:kaquiz/api/api.dart';
import 'package:kaquiz/components/user_field.dart';

import '../components/menu_button.dart';
import '../provider/provider_manager.dart';
import '../utils/colors.dart';
import '../utils/user.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  late User user;
  String errorMSg = '';
  bool inbound = true;
  bool outbound = false;
  List<MapEntry<String, dynamic>> inboundUsers = [];
  List<MapEntry<String, dynamic>> outboundUsers = [];

  Future<void> getInvReq() async {
    var allData;
    await Api().readPath(collection: "friends", path: user.email).then((value) {
      setState(() {
        allData = value.data();
      });
    });
    inboundUsers = allData["inbound"].entries.toList();
    outboundUsers = allData["outbound"].entries.toList();
  }

  void onPressed(type) {
    if (type == "Inbound" && !inbound ||type == "Outbound" && !outbound) {
      setState(() {
        inbound = !inbound;
        outbound = !outbound;
      });
    }
  }

  @override
  void initState() {
    user = ProviderManager().getUser(context);
    getInvReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Column(
        children: [
          _menu,
          const SizedBox(height: 30),
          Column(
            children: [
              if (inbound && inboundUsers != [])
                for (var userIn in inboundUsers)
                  UserField(
                      type: "Inbound",
                      user: user,
                      username: userIn.value,
                      email: userIn.key,
                      resetState: () => {},
                      setErrorState: _setErrorState)
              else if (!inbound && outboundUsers != [])
                for (var userOut in outboundUsers)
                  UserField(
                      type: "Outbound",
                      user: user,
                      username: userOut.value,
                      email: userOut.key,
                      resetState: () => {},
                      setErrorState: _setErrorState)
              else
                _setInfoWidget
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
    errorMSg = msg;
  }

  Widget get _setInfoWidget {
    return Center(
        child: Text(
      errorMSg,
      style: const TextStyle(
        color: primeColorTrans,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
