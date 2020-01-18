import 'package:flutter/material.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/galaxyList.dart';

class PhoneCustomizationProvider extends ChangeNotifier {
  List<PhoneModel> pixels = pixelList;
  List<PhoneModel> iPhones = iPhoneList;
  List<PhoneModel> samsungs = galaxyList;

  void notify() => notifyListeners();

  //COLORS
  Map currentColors;
  String currentSide;
  Color currentColor, selectedColor;

  void getColors(List phoneList, int phoneIndex) =>
      currentColors = phoneList[phoneIndex].colors;

  void getCurrentColor(int i) =>
      currentColor = currentColors.values.elementAt(i);

  void setCurrentSide(int i) => currentSide = currentColors.keys.elementAt(i);

  void colorSelected(Color color) => selectedColor = color;

  void changeColor(bool noTexture) {
    currentColors[currentSide] = selectedColor ?? currentColor;
    if (!noTexture) currentTextures[currentSide].asset = null;
    notifyListeners();
  }

  //TEXTURES
  Map currentTextures;
  String currentTexture, selectedTexture;
  Color currentBlendColor, selectedBlendColor;
  BlendMode currentBlendMode, selectedBlendMode;

  void getTextures(List phoneList, int phoneIndex) =>
      currentTextures = phoneList[phoneIndex].textures;

  void getCurrentSideTextureDetails(int i) {
    currentTexture = currentTextures.values.elementAt(i).asset;
    currentBlendColor = currentTextures.values.elementAt(i).blendColor;
    currentBlendMode = currentTextures.values.elementAt(i).blendMode;
  }

  void textureSelected(String texture) {
    selectedTexture = texture;
    notifyListeners();
  }

  void textureBlendModeIndexSelected(int index) {
    currentBlendMode = myBlendModes[index].mode;
    notifyListeners();
  }

  void textureBlendColorSelected(Color color) {
    currentBlendColor = color;
    notifyListeners();
  }

  void changeTexture() {
    currentTextures[currentSide].blendColor =
        selectedBlendColor ?? currentBlendColor;
    currentTextures[currentSide].blendMode =
        selectedBlendMode ?? currentBlendMode;
    currentTextures[currentSide].asset = selectedTexture ?? currentTexture;
    notifyListeners();
  }
}
