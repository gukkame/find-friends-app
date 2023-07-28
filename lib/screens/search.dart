import 'package:flutter/material.dart';
import 'package:kahoot/api/general_api.dart';

import '../components/container.dart';
import '../components/user_field.dart';
import '../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<String?> user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 100, 30, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(height: 20),
          RoundedGradientContainer(
            gradient: primeGradient,
            borderSize: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 2,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      
                      controller: _titleController,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
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
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerRight),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //! Search for Username
                          user = GeneralApi()
                              .getUsername(email: _titleController.text);
                          setState(() {
                            user = user;
                          });

                          print(_titleController.text);
                          print(user);
                        } else {
                          debugPrint("Invalid");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: primeGradient,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 13.5),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          FutureBuilder(
              future: user,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    var data = snapshot.data ?? "";
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(children: [
                        const Center(
                            child: Text(
                          "User found!",
                          style: TextStyle(
                            // decoration: TextDecoration.underline,
                            color: primeColor,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(height: 30),
                        UserField(username: data),
                    
                      ]),
                    );
                  } else {
                    return const Center(
                        child: Text(
                      "No users found!",
                      style: TextStyle(
                        color: primeColorTrans,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ));
                  }
                } else {
                  return const Center(
                    child: Text(
                      "Loading...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: primeColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
              }))
          // ListView(
          //   children: [],
          // )
        ],
      ),
    );
  }
}
