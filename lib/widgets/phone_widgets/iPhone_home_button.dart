import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class IPhoneHomeButton extends StatelessWidget {
  final double diameter, trimWidth, squareMargin;
  final Color buttonColor, squareColor, trimColor, backPanelColor;
  final bool hasElevation, hasSquare;
  final int phoneID;
  final String boxColorKey;

  const IPhoneHomeButton({
    @required this.phoneID,
    this.diameter = 40.0,
    this.trimWidth = 2.0,
    this.squareMargin = 20.0,
    this.buttonColor = Colors.white,
    this.boxColorKey,
    this.squareColor,
    this.trimColor,
    this.hasElevation = false,
    this.backPanelColor = Colors.black,
    this.hasSquare = false,
  });

  @override
  Widget build(BuildContext context) {
    Box<dynamic> phonesBox =
        Provider.of<CustomizationProvider>(context).phonesBox;

    var boxTrimColor = phonesBox.get(phoneID).colors[boxColorKey ?? 'Bezels'];

    return Container(
      width: diameter,
      height: diameter,
      child: FittedBox(
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor,
            border: Border.all(
              color: trimColor == null
                  ? boxTrimColor == null
                      ? buttonColor.computeLuminance() > 0.335
                          ? Colors.grey[300]
                          : Colors.grey[800]
                      : boxTrimColor.withOpacity(0.5)
                  : trimColor,
              width: trimWidth,
            ),
            boxShadow: hasElevation
                ? [
                    BoxShadow(
                      color: backPanelColor.computeLuminance() > 0.335
                          ? Colors.black26
                          : Colors.black38,
                      spreadRadius: 1.0,
                      blurRadius: 3.0,
                    )
                  ]
                : null,
          ),
          child: hasSquare
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: diameter - squareMargin,
                      height: diameter - squareMargin,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(squareMargin / 4.5),
                        color: buttonColor,
                        border: Border.all(
                          color: squareColor == null
                              ? buttonColor.computeLuminance() > 0.335
                                  ? Colors.grey[300]
                                  : Colors.grey[800]
                              : squareColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
