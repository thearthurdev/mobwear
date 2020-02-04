import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class NoPhonesFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          LineAwesomeIcons.mobile_phone,
          size: 40,
        ),
        const SizedBox(height: 10),
        Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Text(
            'No phones found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'Quicksand',
            ),
          ),
        ),
      ],
    );
  }
}
