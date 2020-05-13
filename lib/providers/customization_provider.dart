import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/models/blend_mode_model.dart';
import 'package:mobwear/data/models/phone_data_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/phone_database.dart';

class CustomizationProvider extends ChangeNotifier {
  //GENERAL
  bool isCapturePage = false;
  bool isEditPage = false;
  bool isCustomizationCopied = false;
  bool isSaving = false;

  void changeCapturePageStatus(bool b) => isCapturePage = b;
  void changeEditPageStatus(bool b) => isEditPage = b;
  void changeSavingState(bool b) => isSaving = b;

  //Box opened in this class to listen to changes. DO NOT REMOVE!
  Box phonesBox = PhoneDatabase.phonesBox;

  int currentPhoneID;
  int currentPhoneBrandIndex;
  int currentPhoneIndex;
  String currentSide;
  String previousSide;
  PhoneDataModel currentPhoneData;
  Map<String, Color> currentColors;
  Map<String, MyTexture> currentTextures;

  void setCurrentPhoneData({int phoneID, int phoneBrandIndex, int phoneIndex}) {
    currentPhoneID = phoneID;
    currentPhoneData = PhoneDatabase.phonesBox.get(phoneID);
    currentPhoneBrandIndex = phoneBrandIndex;
    currentPhoneIndex = phoneIndex;

    currentColors = {};
    currentTextures = {};
    currentColors.addAll(currentPhoneData.colors);
    currentTextures.addAll(currentPhoneData.textures);
  }

  void setCurrentSide(int i) => currentSide = currentColors.keys.elementAt(i);
  void setPreviousSide() => previousSide = currentSide;

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

  void resetCustomization(bool noTexture) {
    Color defaultSideColor = PhoneDataModel
        .phonesDataLists[currentPhoneBrandIndex][currentPhoneIndex]
        .colors[currentSide];

    currentColors[currentSide] = defaultSideColor;
    if (!noTexture) {
      currentTextures[currentSide].asset = null;
      currentTextures[currentSide].blendColor = Colors.deepOrange;
      currentTextures[currentSide].blendModeIndex = 0;
    }

    updateDatabase();
    notifyListeners();
  }

  Color tempColor;
  String tempTexture;
  Color tempBlendColor;
  int tempBlendModeIndex;

  void setTempValues(bool noTexture) {
    resetTempValues();
    if (!noTexture) {
      tempColor = currentColors[currentSide];
      tempTexture = currentTextures[currentSide].asset;
      tempBlendColor = currentTextures[currentSide].blendColor;
      tempBlendModeIndex = currentTextures[currentSide].blendModeIndex;
    } else {
      tempColor = currentColors[currentSide];
    }
  }

  void undo(bool noTexture) {
    if (!noTexture) {
      colorSelected(tempColor);
      textureSelected(tempTexture);
      textureBlendColorSelected(tempBlendColor);
      textureBlendModeIndexSelected(tempBlendModeIndex);
    } else {
      colorSelected(tempColor);
    }

    if (tempTexture != null) {
      changeTexture();
    } else {
      changeColor(noTexture);
    }

    isCustomizationCopied = false;

    resetTempValues();
    notifyListeners();
  }

  void updateDatabase() {
    PhoneDatabase.phonesBox.put(
      currentPhoneID,
      PhoneDataModel(
        id: currentPhoneID,
        colors: currentColors,
        textures: currentTextures,
      ),
    );
  }

  void resetTempValues() {
    tempColor = null;
    tempTexture = null;
    tempBlendColor = null;
    tempBlendModeIndex = null;
  }

  void resetSelectedValues() {
    selectedColor = null;
    selectedTexture = null;
    selectedBlendColor = null;
    selectedBlendModeIndex = null;
    selectedWatermarkColor = null;
    selectedWatermarkIndex = null;
  }

  void resetCurrentValues() {
    currentColor = null;
    currentTexture = null;
    currentBlendColor = null;
    currentBlendModeIndex = null;
    watermarkColor = null;
  }

  //PICTURE MODE
  bool showWatermark = true;
  int aspectRatioIndex = 0;
  int watermarkIndex = 0;
  int watermarkPositionIndex = 7;
  int selectedWatermarkIndex;
  Color watermarkColor, selectedWatermarkColor;

  Map<String, bool> myWatermarkOptions = {
    'Show watermark': true,
    'Hide watermark': false,
  };

  void changeAspectRatioIndex(int i) {
    aspectRatioIndex = i;
    notifyListeners();
  }

  void watermarkStateSelected(bool b) {
    showWatermark = b;
    notifyListeners();
  }

  void watermarkColorSelected(Color color) {
    selectedWatermarkColor = color;
    notifyListeners();
  }

  void watermarkIndexSelected(int i) {
    selectedWatermarkIndex = i;
    notifyListeners();
  }

  void watermarkPositionIndexSelected(int i) {
    watermarkPositionIndex = i;
    notifyListeners();
  }

  void setWatermark() {
    watermarkIndex = selectedWatermarkIndex ?? watermarkIndex;
    watermarkColor = selectedWatermarkColor ?? watermarkColor;
    notifyListeners();
  }

  //PHONE COLORS
  Color currentColor, selectedColor;

  void getCurrentColor(int i) =>
      currentColor = currentColors.values.elementAt(i);

  void colorSelected(Color color) => selectedColor = color;

  void changeColor(bool noTexture) {
    if (isCapturePage) {
      currentColor = selectedColor;
      if (!noTexture) {
        currentTexture = null;
      }
    } else {
      currentColors[currentSide] = selectedColor ?? currentColor;
      if (!noTexture) {
        currentTextures[currentSide].asset = null;
      }

      updateDatabase();
    }
    notifyListeners();
  }

  //PHONE TEXTURES
  String currentTexture, selectedTexture;
  Color currentBlendColor, selectedBlendColor;
  int currentBlendModeIndex, selectedBlendModeIndex;
  BlendMode currentBlendMode;

  void getCurrentSideTextureDetails({int i}) {
    if (isCapturePage) {
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
    if (isCapturePage) {
      currentTexture = selectedTexture ?? currentTexture;
      currentBlendColor = selectedBlendColor ?? currentBlendColor;
      currentBlendModeIndex = selectedBlendModeIndex ?? currentBlendModeIndex;
    } else {
      currentTextures[currentSide].asset = selectedTexture ?? currentTexture;
      currentTextures[currentSide].blendColor =
          selectedBlendColor ?? currentBlendColor;
      currentTextures[currentSide].blendModeIndex =
          selectedBlendModeIndex ?? currentBlendModeIndex;

      updateDatabase();
    }
    notifyListeners();
  }
}
