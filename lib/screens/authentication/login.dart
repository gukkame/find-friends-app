import 'package:flutter/material.dart';
import 'package:kahoot/navigation.dart';

import '../../components/container.dart';
import '../../components/scaffold.dart';
import '../../utils/colors.dart';

class LogIn extends StatefulWidget {
  // late DB _db;
  late String _title;
  late double _scaffoldBorderRadius;

  // get db => _db;
  get title => _title;
  get borderRadius => _scaffoldBorderRadius;

  LogIn(
      {super.key,
      // required DB db,
      required String title,
      double scaffoldBorderRadius = 20.0}) {
    // _db = db;
    _title = title;
    _scaffoldBorderRadius = scaffoldBorderRadius;
  }

  @override
  State<LogIn> createState() => _AddNoteState();
}

class _AddNoteState extends State<LogIn> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BorderColor titleCheck = BorderColor.neutral;
  BorderColor descCheck = BorderColor.neutral;

  @override
  Widget build(BuildContext context) {
    return RoundScaffold(
      title: widget.title,
      rounding: widget.borderRadius,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 28,
                        color: primeColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  RoundedGradientContainer(
                    gradient: titleCheck == BorderColor.error
                        ? errorGradient
                        : titleCheck == BorderColor.correct
                            ? correctGradient
                            : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: titleCheck == BorderColor.error ? 5 : 0),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Email",
                              border: titleCheck != BorderColor.error
                                  ? InputBorder.none
                                  : null),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              titleCheck = BorderColor.error;
                              return "Email required";
                            } else if (!value.contains("@") ||
                                !value.contains(".") ||
                                value.length < 4) {
                              titleCheck = BorderColor.error;
                              return "Email is wrong";
                            } else {
                              titleCheck = BorderColor.correct;
                              return null;
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  RoundedGradientContainer(
                    gradient: descCheck == BorderColor.error
                        ? errorGradient
                        : descCheck == BorderColor.correct
                            ? correctGradient
                            : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: descCheck == BorderColor.error ? 5 : 0,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _descController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Password",
                              border: descCheck != BorderColor.error
                                  ? InputBorder.none
                                  : null),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              descCheck = BorderColor.error;
                              return "Password required";
                            } else {
                              descCheck = BorderColor.correct;
                              return null;
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => navigate(context, "/signup"),
                    child: const Text(
                      "Dont have an account? Click here!",
                      style: TextStyle(
                          fontSize: 14,
                          color: primeColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {});
                          //! BE Check DB if correct, navigate to friend list page, if not, display error
                          // widget.db.addNote(
                          //     _titleController.text, _descController.text);
                          // navigate(context, "/friend-list");
                        } else {
                          debugPrint("Invalid");
                          setState(() {});
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: primeGradient,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            )),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}

enum BorderColor { neutral, error, correct }
