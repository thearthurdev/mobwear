import 'package:flutter/material.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/galaxyList.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/customization_picker_dialog.dart';

class PhonesData extends ChangeNotifier {
  List<PhoneModel> pixels = pixelList;
  List<PhoneModel> iPhones = iPhoneList;
  List<PhoneModel> samsungs = galaxyList;

  Map getColors(List phoneList, int phoneIndex) {
    return phoneList[phoneIndex].colors;
  }

  void notify() => notifyListeners();

  void changeColor({
    BuildContext context,
    Map colors,
    String side,
    Color selectedColor,
    String selectedSide,
    int index,
  }) {
    Color colorPicked;
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.grey[900]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: CustomizationPickerDialog(
            context, selectedColor, selectedSide, colorPicked, colors, index),
      ),
    );
  }
}
