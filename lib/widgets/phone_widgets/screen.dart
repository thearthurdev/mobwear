import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/phone_widgets/specs_screen.dart';
import 'package:provider/provider.dart';

class Screen extends StatelessWidget {
  final double screenWidth, screenHeight, bezelsWidth;
  final double verticalPadding, horizontalPadding;
  final double cornerRadius, innerCornerRadius;
  final double notchWidth, notchHeight;
  final String boxColorKey;
  final int phoneID;
  final bool hasNotch, noButtons, hasBackPanelColor;
  final Alignment screenAlignment, notchAlignment;
  final Color screenFaceColor, bezelsColor;
  final List<Widget> leftButtons, rightButtons, topButtons;

  final List<Widget> screenItems;
  final String phoneName, phoneModel, phoneBrand;

  const Screen({
    @required this.phoneName,
    @required this.phoneModel,
    @required this.phoneBrand,
    @required this.phoneID,
    this.screenWidth = 240.0,
    this.screenHeight = 500.0,
    this.verticalPadding = 18.0,
    this.horizontalPadding = 18.0,
    this.cornerRadius = 30.0,
    this.bezelsWidth = 1.0,
    this.hasNotch = false,
    this.noButtons = false,
    this.hasBackPanelColor = false,
    this.screenAlignment = Alignment.center,
    this.notchAlignment = Alignment.topCenter,
    this.notchWidth = 120.0,
    this.notchHeight = 25.0,
    this.innerCornerRadius,
    this.screenFaceColor = Colors.black,
    this.bezelsColor,
    this.screenItems,
    this.boxColorKey,
    this.leftButtons,
    this.rightButtons,
    this.topButtons,
  });

  @override
  Widget build(BuildContext context) {
    if (noButtons) return screen(context);

    return FittedBox(
      child: Center(
        child: Column(
          children: <Widget>[
            topButtonsList(topButtons),
            Row(
              children: <Widget>[
                sideButtonsList(leftButtons),
                screen(context),
                sideButtonsList(rightButtons),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget screen(BuildContext context) {
    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    Color boxBezelsColor =
        phonesBox.get(phoneID).colors[boxColorKey ?? 'Bezels'];

    Color boxBackPanelColor =
        phonesBox.get(phoneID).colors[boxColorKey ?? 'Back Panel'];

    //Screen frame
    return AnimatedContainer(
      width: screenWidth,
      height: screenHeight,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: hasBackPanelColor ? boxBackPanelColor : screenFaceColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        border: Border.all(
          color: bezelsColor == null
              ? boxBezelsColor == null ||
                      boxBezelsColor == Colors.black ||
                      boxBezelsColor.alpha < 40
                  ? kThemeBrightness(context) == Brightness.light
                      ? Colors.transparent
                      : Colors.grey[900]
                  : boxBezelsColor
              : bezelsColor,
          width: bezelsWidth,
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
            alignment: screenAlignment,
            heightFactor: verticalPadding,
            //Screen itself
            child: Container(
              width: screenWidth - horizontalPadding,
              height: screenHeight - verticalPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  innerCornerRadius != null
                      ? innerCornerRadius
                      : cornerRadius - 5.0,
                ),
                color: kThemeBrightness(context) == Brightness.light
                    ? Colors.white
                    : Colors.grey[900],
              ),
              child: SpecsScreen(
                phoneBrand: phoneBrand,
                phoneModel: phoneModel,
                phoneName: phoneName,
              ),
            ),
          ),
          hasNotch
              ? Align(
                  alignment: notchAlignment,
                  //Notch
                  child: Container(
                    width: notchWidth,
                    height: notchHeight,
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
              children: screenItems ?? [],
            ),
          ),
          Align(
            alignment: screenAlignment,
            heightFactor: verticalPadding,
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  innerCornerRadius != null
                      ? innerCornerRadius
                      : cornerRadius - 5.0,
                ),
                child: Container(
                  width: screenWidth - horizontalPadding,
                  height: screenHeight - verticalPadding,
                  decoration: BoxDecoration(
                    border: screenFaceColor == Colors.white
                        ? kThemeBrightness(context) == Brightness.light
                            ? Border.all(
                                color: Colors.grey[300],
                                width: 1.0,
                              )
                            : null
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideButtonsList(List<Widget> buttons) {
    return buttons != null && !noButtons
        ? Container(
            height: screenHeight,
            child: Stack(
              children: buttons,
            ),
          )
        : SizedBox();
  }

  Widget topButtonsList(List<Widget> buttons) {
    return buttons != null && !noButtons
        ? Container(
            width: screenWidth,
            child: Stack(
              children: buttons,
            ),
          )
        : SizedBox();
  }
}
