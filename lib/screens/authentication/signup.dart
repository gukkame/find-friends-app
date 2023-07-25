import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kahoot/navigation.dart';

import '../../components/container.dart';
import '../../components/scaffold.dart';
import '../../utils/colors.dart';

class SignUp extends StatefulWidget {
  // late DB _db;
  late double _scaffoldBorderRadius;

  // get db => _db;
  get borderRadius => _scaffoldBorderRadius;

  SignUp(
      {super.key,
      // required DB db,
      double scaffoldBorderRadius = 20.0}) {
    // _db = db;
    _scaffoldBorderRadius = scaffoldBorderRadius;
  }

  @override
  State<SignUp> createState() => _AddNoteState();
}

class _AddNoteState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BorderColor usernameCheck = BorderColor.neutral;
  BorderColor emailCheck = BorderColor.neutral;
  BorderColor passCheck = BorderColor.neutral;
  BorderColor pass2Check = BorderColor.neutral;

  @override
  Widget build(BuildContext context) {
    return RoundScaffold(
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
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 28,
                        color: primeColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  RoundedGradientContainer(
                    gradient: usernameCheck == BorderColor.error
                        ? errorGradient
                        : usernameCheck == BorderColor.correct
                            ? correctGradient
                            : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                usernameCheck == BorderColor.error ? 5 : 0),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Username",
                              border: usernameCheck != BorderColor.error
                                  ? InputBorder.none
                                  : null),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 4) {
                              usernameCheck = BorderColor.error;
                              return "Username required";
                            } else {
                              usernameCheck = BorderColor.correct;
                              return null;
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  RoundedGradientContainer(
                    gradient: emailCheck == BorderColor.error
                        ? errorGradient
                        : emailCheck == BorderColor.correct
                            ? correctGradient
                            : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: emailCheck == BorderColor.error ? 5 : 0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Email",
                              border: emailCheck != BorderColor.error
                                  ? InputBorder.none
                                  : null),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              emailCheck = BorderColor.error;
                              return "Email required";
                            } else if (!value.contains("@") ||
                                !value.contains(".") ||
                                value.length < 4) {
                              emailCheck = BorderColor.error;
                              return "Email is wrong";
                            } else {
                              emailCheck = BorderColor.correct;
                              return null;
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  RoundedGradientContainer(
                    gradient: passCheck == BorderColor.error
                        ? errorGradient
                        : passCheck == BorderColor.correct
                            ? correctGradient
                            : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: passCheck == BorderColor.error ? 5 : 0,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Password",
                              border: passCheck != BorderColor.error
                                  ? InputBorder.none
                                  : null),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != _password2Controller.value.text) {
                              passCheck = BorderColor.error;
                              return "Password required";
                            } else {
                              passCheck = BorderColor.correct;
                              return null;
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  RoundedGradientContainer(
                    gradient: pass2Check == BorderColor.error
                        ? errorGradient
                        : pass2Check == BorderColor.correct
                            ? correctGradient
                            : null,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: pass2Check == BorderColor.error ? 5 : 0,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _password2Controller,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              hintText: "Password",
                              border: pass2Check != BorderColor.error
                                  ? InputBorder.none
                                  : null),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != _passwordController.value.text) {
                              pass2Check = BorderColor.error;
                              return "Password incorect or doesn't match";
                            } else {
                              pass2Check = BorderColor.correct;
                              return null;
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => navigate(context, "/login"),
                    child: const Text(
                      "Already have an account? Click here!",
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
