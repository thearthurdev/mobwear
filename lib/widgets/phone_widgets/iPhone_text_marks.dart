import 'package:flutter/material.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';

class IPhoneTextMarks extends StatelessWidget {
  final Color color;
  final int storageCapacity;
  final String phoneID;
  final bool designedByText;
  final bool isSingleLine;
  final bool idNumbersText;
  final bool ceMarkings;
  final bool storageText;

  const IPhoneTextMarks({
    @required this.color,
    this.storageCapacity = 8,
    this.phoneID = '2020',
    this.designedByText = true,
    this.isSingleLine = false,
    this.idNumbersText = false,
    this.ceMarkings = true,
    this.storageText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'iPhone',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 6.0),
            ],
          ),
          designedByText
              ? Column(
                  children: <Widget>[
                    Text(
                      'Designed By Apple In California ${isSingleLine ? '' : '\n'}Assembled In China',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 5.0,
                        color: color,
                      ),
                    ),
                    SizedBox(height: ceMarkings && !idNumbersText ? 8.0 : 0.0),
                  ],
                )
              : Container(),
          idNumbersText
              ? Column(
                  children: <Widget>[
                    Text(
                      'Model No.:M$phoneID  FCC ID:DAGH007P  IC ID: 521X-M${phoneID}A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 5.0,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                )
              : Container(),
          ceMarkings
              ? Column(
                  children: <Widget>[
                    Row(
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
                    ),
                    SizedBox(height: 6.0),
                  ],
                )
              : Container(),
          storageText
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: color,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    '${storageCapacity}GB',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: color,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
