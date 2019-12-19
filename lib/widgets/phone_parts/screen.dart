import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/phone_parts/specs_screen.dart';

class Screen extends StatefulWidget {
  final double screenWidth,
      screenHeight,
      bezelVertical,
      bezelHorizontal,
      cornerRadius,
      innerCornerRadius,
      notchWidth,
      notchHeight;
  final bool hasNotch;
  final String wallPaper, phoneBrand, phoneModel, phoneName;
  final Alignment screenAlignment, notchAlignment;
  final Color screenBezelColor;
  final List<Widget> screenItems;

  const Screen({
    this.screenWidth = 250.0,
    this.screenHeight = 500.0,
    this.bezelVertical = 15.0,
    this.bezelHorizontal = 15.0,
    this.cornerRadius = 30.0,
    this.hasNotch = false,
    this.wallPaper,
    this.screenAlignment = Alignment.center,
    this.notchAlignment = Alignment.topCenter,
    this.notchWidth = 120.0,
    this.notchHeight = 25.0,
    this.innerCornerRadius,
    this.screenBezelColor = Colors.black,
    this.screenItems,
    this.phoneBrand,
    this.phoneModel,
    this.phoneName,
  });

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      //Screen frame
      child: Container(
        width: widget.screenWidth + 1.2,
        height: widget.screenHeight + 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.cornerRadius),
          color: kThemeBrightness(context) == Brightness.light
              ? Colors.transparent
              : Colors.grey[800],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5, 5),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: widget.screenWidth,
            height: widget.screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              border: Border.all(
                color: widget.screenBezelColor,
              ),
              color: widget.screenBezelColor,
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: widget.screenAlignment,
                  heightFactor: widget.bezelVertical,
                  //Screen itself
                  child: Container(
                    width: widget.screenWidth - widget.bezelHorizontal,
                    height: widget.screenHeight - widget.bezelVertical,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        widget.innerCornerRadius != null
                            ? widget.innerCornerRadius
                            : widget.cornerRadius - 5.0,
                      ),
                      color: kThemeBrightness(context) == Brightness.light
                          ? Colors.white
                          : Colors.grey[900],
                    ),
                  ),
                ),
                widget.hasNotch
                    ? Align(
                        alignment: widget.notchAlignment,
                        //Notch
                        child: Container(
                          width: widget.notchWidth,
                          height: widget.notchHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Container(),
                Center(
                  child: Stack(
                    fit: StackFit.expand,
                    children: widget.screenItems ?? [],
                  ),
                ),
                Align(
                  alignment: widget.screenAlignment,
                  heightFactor: widget.bezelVertical,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.innerCornerRadius != null
                          ? widget.innerCornerRadius
                          : widget.cornerRadius - 5.0,
                    ),
                    child: Container(
                      width: widget.screenWidth - widget.bezelHorizontal,
                      height: widget.screenHeight - widget.bezelVertical,
                      decoration: BoxDecoration(
                        border: widget.screenBezelColor == Colors.white
                            ? kThemeBrightness(context) == Brightness.light
                                ? Border.all(
                                    color: Colors.grey[300],
                                    width: 1.0,
                                  )
                                : null
                            : null,
                      ),
                      child: SpecsScreen(
                        phoneBrand: widget.phoneBrand,
                        phoneModel: widget.phoneModel,
                        phoneName: widget.phoneName,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
