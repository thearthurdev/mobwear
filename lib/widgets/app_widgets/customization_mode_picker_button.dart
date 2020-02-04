import 'package:flutter/material.dart';
import 'package:mobware/data/models/mode_picker_model.dart';
import 'package:mobware/utils/constants.dart';

class CustomizationModePickerButton extends StatelessWidget {
  final Icon icon;
  final PickerMode pickerMode;
  final Function onTap;
  final bool isSelected;

  const CustomizationModePickerButton({
    this.icon,
    this.pickerMode,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      width: 2.0,
                      color: kBrightnessAwareColor(context,
                          lightColor: Colors.black, darkColor: Colors.white),
                    )
                  : null,
            ),
          ),
        ),
        Center(
          child: IconButton(
            icon: icon,
            color: kBrightnessAwareColor(context,
                lightColor: Colors.black, darkColor: Colors.white),
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}
