import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, String text) {
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
          label: 'Okay',
          textColor: Colors.white,
          onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
