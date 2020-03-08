import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class PhoneGroupViewPickerButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  final double size;

  const PhoneGroupViewPickerButton(
      {this.icon, this.isSelected, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.0,
      height: 36.0,
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1.5,
          color: isSelected
              ? kBrightnessAwareColor(context,
                  lightColor: Colors.black, darkColor: Colors.white)
              : Colors.transparent,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () => onTap(),
          child: Icon(
            icon,
            color: isSelected
                ? kBrightnessAwareColor(context,
                    lightColor: Colors.black, darkColor: Colors.white)
                : kBrightnessAwareColor(context,
                    lightColor: Colors.black54, darkColor: Colors.white54),
            size: size,
          ),
        ),
      ),
    );
  }
}
