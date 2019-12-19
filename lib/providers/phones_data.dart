import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:mobware/data/phone_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/samsungList.dart';

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
      builder: (BuildContext context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text('Pick a color'),
        children: <Widget>[
          MaterialColorPicker(
            shrinkWrap: true,
            onColorChange: (Color color) {
              colorPicked = color;
            },
            selectedColor: selectedColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
    );
  }
}
