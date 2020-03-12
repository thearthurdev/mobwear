import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';

class MyFlushbars {
  static void showMultipleFlusbars(List flushbars) {}

  static void showTipFlushbar(
    BuildContext context, {
    String title,
    String message,
    Function onDismiss,
  }) {
    Flushbar(
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: kTitleTextStyle.copyWith(
              color: kBrightnessAwareColor(context,
                  lightColor: Colors.white, darkColor: Colors.black),
            ),
          ),
          Text(
            'swipe to dismiss',
            style: kSubtitleTextStyle.copyWith(
              color: kBrightnessAwareColor(context,
                  lightColor: Colors.white70, darkColor: Colors.black87),
            ),
          ),
        ],
      ),
      messageText: Text(
        message,
        style: kTitleTextStyle.copyWith(
          color: kBrightnessAwareColor(context,
              lightColor: Colors.white, darkColor: Colors.black),
        ),
      ),
      icon: Icon(
        LineAwesomeIcons.info_circle,
        color: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8.0),
      borderRadius: 10.0,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: kBrightnessAwareColor(context,
          lightColor: Colors.black87, darkColor: Colors.white),
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED) {
          onDismiss();
        }
      },
    )..show(context);
  }
}
