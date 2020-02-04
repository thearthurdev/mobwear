import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class TextureBlendColorPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        Color selectedColor =
            provider.selectedBlendColor ?? provider.currentBlendColor;

        return SimpleDialog(
          titlePadding: EdgeInsets.fromLTRB(20.0, 16.0, 13.0, 0.0),
          title: Row(
            children: <Widget>[
              Text(
                'Blend Color',
                style: kTitleTextStyle.copyWith(fontSize: 18.0),
              ),
              Expanded(child: Container()),
              IconButton(
                icon: Icon(LineAwesomeIcons.check_circle),
                onPressed: () {
                  provider.textureBlendColorSelected(selectedColor);
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(LineAwesomeIcons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 16.0),
              child: Center(
                child: CircleColorPicker(
                  initialColor:
                      provider.selectedBlendColor ?? provider.currentBlendColor,
                  size: Size(300.0, 300.0),
                  onChanged: (color) => selectedColor = color,
                  strokeWidth: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
