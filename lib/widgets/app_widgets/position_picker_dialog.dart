import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/adaptiveDialog.dart';
import 'package:provider/provider.dart';

class PositionPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLongScreen = kDeviceHeight(context) <= 900.0;

    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        return AdaptiveDialog(
          title: 'Position',
          hasSelectButton: false,
          maxWidth: 300.0,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: isLongScreen
                  ? kDeviceHeight(context) - kScreenAwareSize(320.0, context)
                  : kDeviceHeight(context),
            ),
            child: Scrollbar(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: MyPosition.myPositions.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                    title: Text(MyPosition.myPositions[i].name),
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
        );
      },
    );
  }
}
