import 'dart:math';

import 'package:flutter/material.dart';

class SharePhonePageProvider extends ChangeNotifier {
  Color backgroundColor, currentColor, selectedColor;

  Color initBackgroundColor() {
    Color randomColor;
    if (selectedColor == null) {
      randomColor = Colors.primaries[Random().nextInt(15)];
      backgroundColor = randomColor;
    }
    if (selectedColor != null) {
      backgroundColor = selectedColor;
      randomColor = selectedColor;
    }

    return randomColor;
  }

  void colorSelected(Color color) => selectedColor = color;

  void changeBackroundColor() {
    backgroundColor = selectedColor ?? currentColor;
    notifyListeners();
  }
}
