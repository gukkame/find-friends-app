import 'package:flutter/material.dart';
import '../utils/colors.dart';

class RoundedGradientContainer extends StatelessWidget {
  late Widget? _child;
  late LinearGradient _gradient;
  late double _borderSize;
  late double _outerBorderRadius;
  late double _innerBorderRadius;

  RoundedGradientContainer(
      {super.key,
      double borderSize = 5,
      double outerBorderRadius = 12.0+3,
      double innerBorderRadius = 12.0,
      LinearGradient? gradient,
      Widget? child}) {
    _child = child;
    _borderSize = borderSize;
    _outerBorderRadius = outerBorderRadius;
    _innerBorderRadius = innerBorderRadius;
    _gradient = gradient ?? primeGradient;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_outerBorderRadius)),
          gradient: _gradient),
      child: Padding(
        padding: EdgeInsets.all(_borderSize),
        child: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_innerBorderRadius)),
          color: Colors.white),
            child: _child),
      ),
    );
  }
}
