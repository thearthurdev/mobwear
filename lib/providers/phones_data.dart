import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
// import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:mobware/data/phone_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/samsungList.dart';
import 'package:mobware/utils/constants.dart';

class PhonesData extends ChangeNotifier {
  List<PhoneModel> pixels = pixelList;
  List<PhoneModel> iPhones = iPhoneList;
  List<PhoneModel> samsungs = samsungList;

  Map getColors(List phoneList, int phoneIndex) {
    return phoneList[phoneIndex].colors;
  }

  void changeColor(
    BuildContext context,
    Map colors,
    String side,
    Color selectedColor,
    int i,
  ) {
    Color colorPicked;
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Pick a color', style: kTitleTextStyle),
                // MaterialColorPicker(
                //   shrinkWrap: true,
                //   onColorChange: (Color color) {
                //     colorPicked = color;
                //   },
                //   selectedColor: selectedColor,
                // ),
                SizedBox(height: 8.0),
                ColorPicker(
                  color: selectedColor,
                  onChanged: (color) {
                    colorPicked = color;
                  },
                ),
                SizedBox(height: 8.0),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  buttonTextTheme: ButtonTextTheme.accent,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text('Select'),
                      onPressed: () {
                        if (colorPicked != null) {
                          colors[colors.keys.elementAt(i)] = colorPicked;
                        } else {
                          colors[colors.keys.elementAt(i)] = selectedColor;
                        }
                        notifyListeners();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
