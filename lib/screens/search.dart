import 'package:flutter/material.dart';

import '../components/container.dart';
import '../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          RoundedGradientContainer(
            gradient: null,
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
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
          const SizedBox(height: 20),
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //! Search for Username
                  print(_titleController.text);
                } else {
                  debugPrint("Invalid");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: primeGradient,
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )),
              )),
          // ListView(
          //   children: [],
          // )
        ],
      ),
    );
  }
}
