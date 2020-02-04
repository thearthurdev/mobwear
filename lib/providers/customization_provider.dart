import 'package:flutter/material.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/galaxyList.dart';

class CustomizationProvider extends ChangeNotifier {
  List<PhoneModel> pixels = pixelList;
  List<PhoneModel> iPhones = iPhoneList;
  List<PhoneModel> samsungs = galaxyList;

  List<List<PhoneModel>> phonesList = [pixelList, iPhoneList, galaxyList];

  bool isSharePage = false;

  PhoneModel currentPhone;

  void setCurrentPhone(List phoneList, int phoneIndex) {
    currentPhone = phoneList[phoneIndex];
    getColors();
    getTextures();
  }

  //COLORS
  Map currentColors;
  String currentSide;
  Color currentColor, selectedColor;

  void getColors() => currentColors = currentPhone.colors;

  void getCurrentColor(int i) =>
      currentColor = currentColors.values.elementAt(i);

  void setCurrentSide(int i) => currentSide = currentColors.keys.elementAt(i);

  void colorSelected(Color color) => selectedColor = color;

  void changeColor(bool noTexture) {
    if (isSharePage) {
      currentColor = selectedColor;
      if (!noTexture) currentTexture = null;
    } else {
      currentColors[currentSide] = selectedColor ?? currentColor;
      if (!noTexture) currentTextures[currentSide].asset = null;
    }
    notifyListeners();
  }

  //TEXTURES
  Map currentTextures;
  String currentTexture, selectedTexture;
  Color currentBlendColor, selectedBlendColor;
  BlendMode currentBlendMode, selectedBlendMode;

  void getTextures() => currentTextures = currentPhone.textures;

  void getCurrentSideTextureDetails({int i}) {
    if (isSharePage) {
      if (currentTexture != null) {
      } else {
        currentBlendColor = Colors.deepOrange;
        currentBlendMode = BlendMode.dst;
      }
    } else {
      currentTexture = currentTextures.values.elementAt(i).asset;
      currentBlendColor = currentTextures.values.elementAt(i).blendColor;
      currentBlendMode =
          currentTextures.values.elementAt(i).blendMode ?? BlendMode.dst;
    }
  }

  void resetSelectedValues() {
    selectedColor = null;
    selectedTexture = null;
    selectedBlendColor = null;
    selectedBlendMode = null;
  }

  void resetCurrentValues() {
    currentColor = null;
    currentTexture = null;
    currentBlendColor = null;
    currentBlendMode = null;
  }

  void textureSelected(String texture) {
    selectedTexture = texture;
    notifyListeners();
  }

  void textureBlendModeIndexSelected(int index) {
    selectedBlendMode = myBlendModes[index].mode;
    notifyListeners();
  }

  void textureBlendColorSelected(Color color) {
    selectedBlendColor = color;
    notifyListeners();
  }

  void changeTexture() {
    if (isSharePage) {
      currentTexture = selectedTexture ?? currentTexture;
      currentBlendColor = selectedBlendColor ?? currentBlendColor;
      currentBlendMode = selectedBlendMode ?? currentBlendMode;
    } else {
      currentTextures[currentSide].asset = selectedTexture ?? currentTexture;
      currentTextures[currentSide].blendColor =
          selectedBlendColor ?? currentBlendColor;
      currentTextures[currentSide].blendMode =
          selectedBlendMode ?? currentBlendMode;
    }
    notifyListeners();
  }
}
