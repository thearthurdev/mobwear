import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class GalaxyHomeButton extends StatelessWidget {
  final double width, height, cornerRadius, trimWidth, elevation;
  final Color buttonColor, trimColor;
  final bool hasElevation;
  final int phoneID;
  final String boxColorKey;

  const GalaxyHomeButton({
    @required this.phoneID,
    this.width = 60.0,
    this.height = 24.0,
    this.trimWidth = 1.5,
    this.cornerRadius = 16.0,
    this.elevation = 0.5,
    this.buttonColor,
    this.boxColorKey,
    this.trimColor,
    this.hasElevation = false,
  });

  @override
  Widget build(BuildContext context) {
    Box<dynamic> phonesBox =
        Provider.of<CustomizationProvider>(context).phonesBox;

    var boxBackPanelColor =
        phonesBox.get(phoneID).colors[boxColorKey ?? 'Back Panel'];

    return FittedBox(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor ?? boxBackPanelColor,
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(
            color: trimColor == null
                ? boxBackPanelColor.computeLuminance() > 0.335
                    ? Colors.grey[350]
                    : Colors.grey[800]
                : trimColor,
            width: trimWidth,
          ),
          boxShadow: hasElevation
              ? [
                  BoxShadow(
                    color: boxBackPanelColor.computeLuminance() > 0.335
                        ? Colors.black.withOpacity(0.1)
                        : Colors.black.withOpacity(0.3),
                    spreadRadius: elevation,
                    blurRadius: 2.0,
                  )
                ]
              : null,
        ),
      ),
    );
  }
}
