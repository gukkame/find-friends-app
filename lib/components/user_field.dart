import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'container.dart';

class UserField extends StatelessWidget {
  final String username;

  Function? updateState;

  UserField({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedGradientContainer(
      borderSize: 2,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0,0,0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight),
                  onPressed: () async {},
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: primeGradient,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 11.0),
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
