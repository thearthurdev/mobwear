import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/custom_icons.dart';

class IPhoneTextMarks extends StatelessWidget {
  final Color color;
  final bool designedByText, ceMarkings;

  const IPhoneTextMarks({
    @required this.color,
    this.designedByText = true,
    this.ceMarkings = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'iPhone',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          designedByText
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Designed By Apple In California\nAssembled In China',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 5.0,
                      color: color,
                    ),
                  ),
                )
              : Container(),
          ceMarkings
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      CustomIcons.ce,
                      size: 18.0,
                      color: color,
                    ),
                    SizedBox(width: 20.0),
                    Icon(
                      CustomIcons.weee,
                      size: 18.0,
                      color: color,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
