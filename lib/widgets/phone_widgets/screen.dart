import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/specs_screen.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final double verticalPadding;
  final double horizontalPadding;
  final double cornerRadius;
  final double innerCornerRadius;
  final double notchWidth;
  final double notchHeight;
  final double bezelsWidth;
  final String bezelsSide;
  final int phoneID;
  final bool hasNotch;
  final Alignment screenAlignment, notchAlignment;
  final Color screenFaceColor, bezelsColor;

  final List<Widget> screenItems;
  final String phoneName, phoneModel, phoneBrand;

  const Screen({
    this.screenWidth = 240.0,
    this.screenHeight = 500.0,
    this.verticalPadding = 18.0,
    this.horizontalPadding = 18.0,
    this.cornerRadius = 30.0,
    this.bezelsWidth = 1.0,
    this.hasNotch = false,
    this.screenAlignment = Alignment.center,
    this.notchAlignment = Alignment.topCenter,
    this.notchWidth = 120.0,
    this.notchHeight = 25.0,
    this.innerCornerRadius,
    this.screenFaceColor = Colors.black,
    this.bezelsColor,
    this.screenItems,
    this.bezelsSide,
    @required this.phoneName,
    @required this.phoneModel,
    @required this.phoneBrand,
    @required this.phoneID,
  });

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    Color boxBezelsColor =
        phonesBox.get(widget.phoneID).colors[widget.bezelsSide ?? 'Bezels'];

    //Screen frame
    return FittedBox(
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: widget.screenWidth,
          height: widget.screenHeight,
          decoration: BoxDecoration(
            color: widget.screenFaceColor,
            borderRadius: BorderRadius.circular(widget.cornerRadius),
            border: Border.all(
              color: widget.bezelsColor == null
                  ? boxBezelsColor == null ||
                          boxBezelsColor == Colors.black ||
                          boxBezelsColor.alpha < 40
                      ? kThemeBrightness(context) == Brightness.light
                          ? Colors.transparent
                          : Colors.grey[900]
                      : boxBezelsColor
                  : widget.bezelsColor,
              width: widget.bezelsWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.blueGrey.withOpacity(0.2),
                    darkColor: Colors.black26),
                offset: Offset(5, 5),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: widget.screenAlignment,
                heightFactor: widget.verticalPadding,
                //Screen itself
                child: Container(
                  width: widget.screenWidth - widget.horizontalPadding,
                  height: widget.screenHeight - widget.verticalPadding,
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
                heightFactor: widget.verticalPadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    widget.innerCornerRadius != null
                        ? widget.innerCornerRadius
                        : widget.cornerRadius - 5.0,
                  ),
                  child: Container(
                    width: widget.screenWidth - widget.horizontalPadding,
                    height: widget.screenHeight - widget.verticalPadding,
                    decoration: BoxDecoration(
                      border: widget.screenFaceColor == Colors.white
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
    );
  }
}
