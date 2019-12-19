import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';

class BackPanel extends StatelessWidget {
  final double width, height, cornerRadius, bezelWidth;
  final Color backPanelColor, bezelColor;
  final Widget child;

  const BackPanel({
    @required this.backPanelColor,
    @required this.bezelColor,
    @required this.child,
    this.width = 240.0,
    this.height = 480.0,
    this.cornerRadius = 23.0,
    this.bezelWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + 1.2,
      height: height + 1.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          color: kThemeBrightness(context) == Brightness.light
              ? Colors.transparent
              : Colors.grey[800],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5, 5),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ]),
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(
              color: bezelColor,
              width: bezelWidth,
            ),
            color: backPanelColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
