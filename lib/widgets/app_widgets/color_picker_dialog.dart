import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class ColorPickerDialog extends StatelessWidget {
  final String title;
  final Color color;
  final Function onSelectPressed;

  const ColorPickerDialog({this.title, this.color, this.onSelectPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        Color selectedColor = color;

        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
          title: Row(
            children: <Widget>[
              Text(
                title,
                style: kTitleTextStyle.copyWith(fontSize: 18.0),
              ),
              Expanded(child: Container()),
            ],
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: CircleColorPicker(
                  initialColor: selectedColor,
                  size: Size(300.0, 300.0),
                  onChanged: (color) => selectedColor = color,
                  strokeWidth: 16.0,
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonTextTheme: ButtonTextTheme.normal,
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: kTitleTextStyle),
                ),
                FlatButton(
                  child: Text('Select', style: kTitleTextStyle),
                  onPressed: () {
                    onSelectPressed(selectedColor);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
