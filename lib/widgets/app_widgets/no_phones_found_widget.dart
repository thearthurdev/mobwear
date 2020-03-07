import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';

class NoPhonesFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAccentButton(icon: LineAwesomeIcons.mobile_phone),
        SizedBox(height: 8.0),
        Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Text(
            'No phones found',
            style: kTitleTextStyle,
          ),
        ),
      ],
    );
  }
}
