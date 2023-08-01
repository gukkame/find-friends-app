import 'package:flutter/material.dart';
import 'package:kaquiz/provider/provider_manager.dart';

import '../api/search_api.dart';
import '../components/container.dart';
import '../components/user_field.dart';
import '../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? user;
  Widget _infoTextWidget = const SizedBox.shrink();
  bool _searchLock = false;
  String _searchedEmail = "";

  @override
  void initState() {
    _setInfoWidget("Search by email");
    super.initState();
  }

  Widget get _searchField {
    return Expanded(
      flex: 2,
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              hintText: "Search by email",
              border: InputBorder.none),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Input required";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget get _searchButton {
    return Expanded(
      flex: 1,
      child: TextButton(
          onPressed: _searchLock ? () {} : _onSearchSubmit,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerRight),
          child: Container(
            decoration: BoxDecoration(
                gradient: primeGradient,
                borderRadius: BorderRadius.circular(12.0)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.5),
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
          )),
    );
  }

  void _onSearchSubmit() async {
    setState(() => _searchLock = true);
    if (_formKey.currentState!.validate()) {
      if (_searchController.value.text ==
          ProviderManager().getUser(context).email) {
        _setErrorState("Can't add yourself as a friend.");
      } else {
        setState(() => _setInfoWidget("Loading..."));
        user =
            await SearchApi().getUsername(email: _searchController.value.text);
        if (user == null) {
          setState(() {
            _setErrorState("No user found.");
          });
        }
      }
    } else {
      debugPrint("Invalid");
    }
    setState(() => _searchLock = false);
  }

  Widget get _userWidget {
    return user != null ? _userFound(user as String) : const SizedBox.shrink();

    // return FutureBuilder(
    //   future: user,
    //   builder: ((context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData) {
    //         var data = snapshot.data as String;
    //         return _userFound(data);
    //       } else {
    //         _setInfoWidget("User not found!");
    //       }
    //     } else if (user == null) {
    //       _setInfoWidget("Search by email");
    //     } else {
    //       _setInfoWidget("Loading...");
    //     }
    //     Future.delayed(Duration.zero).then((_) => setState(() {}));
    //   }),
    // );
  }

  Widget _userFound(String data) {
    _setInfoWidget("User found!");
    _searchedEmail = _searchController.value.text;
    Future.delayed(Duration.zero).then((_) => setState(() {}));
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        const SizedBox(height: 30),
        UserField(
          user: ProviderManager().getUser(context),
          username: data,
          email: _searchedEmail,
          resetState: _resetState,
          setErrorState: _setErrorState,
        ),
      ]),
    );
  }

  void _resetState() {
    setState(() {
      user = null;
      _searchController.value = TextEditingValue.empty;
    });
    Future.delayed(Duration.zero).then((value) {
      _setInfoWidget("Friend request sent!");
      setState(() {});
    });
  }

  void _setErrorState(String msg) {
    _setInfoWidget(msg);
    setState(() {
      user = null;
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 100, 30, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedGradientContainer(
            gradient: primeGradient,
            borderSize: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                _searchField,
                _searchButton,
              ],
            ),
          ),
          const SizedBox(height: 40),
          _infoTextWidget,
          _userWidget,
        ],
      ),
    );
  }
}
