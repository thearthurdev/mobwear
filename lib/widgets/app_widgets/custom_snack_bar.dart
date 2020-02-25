import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomSnackBar {
  static void showSnackBar(
    BuildContext context, {
    String text,
    bool undo = false,
    bool noTexture,
  }) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
          ),
        ),
        backgroundColor: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.grey[900]),
        action: SnackBarAction(
            label: undo ? 'Undo' : 'Okay',
            textColor: Colors.white,
            onPressed: () {
              undo
                  ? Provider.of<CustomizationProvider>(context).undo(noTexture)
                  : Scaffold.of(context).hideCurrentSnackBar();
            }),
      ),
    );
  }
}
