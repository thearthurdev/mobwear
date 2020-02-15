import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class PositionPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Position',
                style: kTitleTextStyle.copyWith(fontSize: 18.0),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: kDeviceWidth(context) - 200,
              constraints: BoxConstraints(
                maxHeight:
                    kDeviceHeight(context) - kScreenAwareSize(330.0, context),
              ),
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Position.myPositions.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                      title: Text(Position.myPositions[i].name),
                      trailing: provider.watermarkPositionIndex == i
                          ? Icon(
                              LineAwesomeIcons.check_circle,
                              color: kBrightnessAwareColor(context,
                                  lightColor: Colors.black,
                                  darkColor: Colors.white),
                            )
                          : null,
                      onTap: () {
                        provider.watermarkPositionIndexSelected(i);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonTextTheme: ButtonTextTheme.normal,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel', style: kTitleTextStyle),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
