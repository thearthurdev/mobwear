import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/data/models/phone_data_model.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/database/phone_database.dart';

class CustomizationProvider extends ChangeNotifier {
  //GENERAL
  bool isSharePage = false;
  bool isCustomizationCopied = false;

  var phonesBox = Hive.box(PhoneDatabase.phones);

  int currentPhoneID;
  int currentPhoneBrandIndex;
  int currentPhoneIndex;
  PhoneDataModel currentPhoneData;
  String currentSide;

  void setCurrentSide(int i) => currentSide = currentColors.keys.elementAt(i);

  void setCurrentPhoneData({int phoneID, int phoneBrandIndex, int phoneIndex}) {
    currentPhoneID = phoneID;
    currentPhoneData = PhoneDatabase.phonesBox.get(phoneID);
    currentPhoneBrandIndex = phoneBrandIndex;
    currentPhoneIndex = phoneIndex;

    getColors();
    getTextures();
  }

  void changeCopyStatus(bool status) {
    isCustomizationCopied = status;
    notifyListeners();
  }

  void copyCustomization(bool noTexture) {
    resetSelectedValues();

    if (!noTexture) {
      colorSelected(currentColors[currentSide]);
      textureSelected(currentTextures[currentSide].asset);
      textureBlendColorSelected(currentTextures[currentSide].blendColor);
      textureBlendModeIndexSelected(
          currentTextures[currentSide].blendModeIndex);
    } else {
      colorSelected(currentColors[currentSide]);
    }

    isCustomizationCopied = true;
    notifyListeners();
  }

  void pasteCustomization(bool noTexture) {
    if (selectedTexture != null) {
      changeTexture();
    } else {
      changeColor(noTexture);
    }
  }

  void resetCurrentSide(bool noTexture) {
    Color defaultSideColor = PhoneDataModel
        .phonesDataLists[currentPhoneBrandIndex][currentPhoneIndex]
        .colors[currentSide];

    currentColors[currentSide] = defaultSideColor;
    if (!noTexture) {
      currentTextures[currentSide].asset = null;
      currentTextures[currentSide].blendColor = Colors.deepOrange;
      currentTextures[currentSide].blendModeIndex = 0;
    }

    PhoneDatabase.phonesBox.put(
      currentPhoneID,
      PhoneDataModel(
        id: currentPhoneID,
        colors: currentColors,
        textures: currentTextures,
      ),
    );
    notifyListeners();
  }

  void resetSelectedValues() {
    selectedColor = null;
    selectedTexture = null;
    selectedBlendColor = null;
    selectedBlendModeIndex = null;
  }

  void resetCurrentValues() {
    currentColor = null;
    currentTexture = null;
    currentBlendColor = null;
    currentBlendModeIndex = null;
  }

  //COLORS
  Map currentColors;
  Color currentColor, selectedColor;

  void getColors() => currentColors = currentPhoneData.colors;

  void getCurrentColor(int i) =>
      currentColor = currentColors.values.elementAt(i);

  void colorSelected(Color color) => selectedColor = color;

  void changeColor(bool noTexture) {
    if (isSharePage) {
      currentColor = selectedColor;
      if (!noTexture) currentTexture = null;
    } else {
      currentColors[currentSide] = selectedColor ?? currentColor;
      if (!noTexture) currentTextures[currentSide].asset = null;

      PhoneDatabase.phonesBox.put(
        currentPhoneID,
        PhoneDataModel(
          id: currentPhoneID,
          colors: currentColors,
          textures: currentTextures,
        ),
      );
    }
    notifyListeners();
  }

  //TEXTURES
  Map currentTextures;
  String currentTexture, selectedTexture;
  Color currentBlendColor, selectedBlendColor;
  int currentBlendModeIndex, selectedBlendModeIndex;
  BlendMode currentBlendMode;

  void getTextures() => currentTextures = currentPhoneData.textures;

  void getCurrentSideTextureDetails({int i}) {
    if (isSharePage) {
      if (currentTexture != null) {
      } else {
        currentBlendColor = Colors.deepOrange;
        currentBlendModeIndex = 0;
      }
    } else {
      MyTexture myTexture = currentTextures.values.elementAt(i);

      currentTexture = myTexture.asset;
      currentBlendColor = myTexture.blendColor;
      currentBlendModeIndex = myTexture.blendModeIndex ?? 0;
      currentBlendMode = MyBlendMode.myBlendModes[currentBlendModeIndex].mode;
    }
  }

  BlendMode getBlendMode(int blendModeIndex) {
    return MyBlendMode.myBlendModes[blendModeIndex].mode;
  }

  void textureSelected(String texture) {
    selectedTexture = texture;
    notifyListeners();
  }

  void textureBlendModeIndexSelected(int index) {
    selectedBlendModeIndex = index;
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
      currentBlendModeIndex = selectedBlendModeIndex ?? currentBlendModeIndex;
    } else {
      currentTextures[currentSide].asset = selectedTexture ?? currentTexture;
      currentTextures[currentSide].blendColor =
          selectedBlendColor ?? currentBlendColor;
      currentTextures[currentSide].blendModeIndex =
          selectedBlendModeIndex ?? currentBlendModeIndex;

      PhoneDatabase.phonesBox.put(
        currentPhoneID,
        PhoneDataModel(
          id: currentPhoneID,
          colors: currentColors,
          textures: currentTextures,
        ),
      );
    }
    notifyListeners();
  }
}
