import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

enum ButtonPosition { left, right, top }

class Button extends StatelessWidget {
  final double width, height, xAlignment, yAlignment, cornerRadius;
  final Color color;
  final ButtonPosition position;
  final int phoneID;
  final String boxColorKey;

  const Button({
    @required this.position,
    @required this.phoneID,
    this.color,
    this.boxColorKey,
    this.xAlignment = 0.0,
    this.yAlignment = 0.0,
    this.width = 2.5,
    this.height = 12.0,
    this.cornerRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry _borderRadius;

    var phonesBox = Provider.of<CustomizationProvider>(context).phonesBox;

    Color boxBackPanelColor =
        phonesBox.get(phoneID).colors[boxColorKey ?? 'Back Panel'];

    switch (position) {
      case ButtonPosition.left:
        _borderRadius = BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          bottomLeft: Radius.circular(cornerRadius),
        );
        break;
      case ButtonPosition.right:
        _borderRadius = BorderRadius.only(
          topRight: Radius.circular(cornerRadius),
          bottomRight: Radius.circular(cornerRadius),
        );
        break;
      case ButtonPosition.top:
        _borderRadius = BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        );
        break;
      default:
    }

    return Align(
      alignment: Alignment(xAlignment, yAlignment),
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color == null
              ? boxBackPanelColor == null ||
                      boxBackPanelColor == Colors.black ||
                      boxBackPanelColor.alpha < 40
                  ? kThemeBrightness(context) == Brightness.light
                      ? boxBackPanelColor
                      : Colors.grey[900]
                  : boxBackPanelColor
              : color,
          borderRadius: _borderRadius,
          border: Border.all(
            width: 0.5,
            color: kThemeBrightness(context) == Brightness.light
                ? Colors.transparent
                : color == null
                    ? boxBackPanelColor == Colors.black ||
                            boxBackPanelColor.alpha < 20
                        ? Colors.grey[850]
                        : boxBackPanelColor
                    : color == Colors.black || color.alpha < 20
                        ? Colors.grey[850]
                        : color,
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
      ),
    );
  }
}
