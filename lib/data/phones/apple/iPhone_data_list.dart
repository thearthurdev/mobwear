import 'package:flutter/material.dart';
import 'package:mobware/data/models/phone_data_model.dart';
import 'package:mobware/data/models/texture_model.dart';

List<PhoneDataModel> iPhoneDataList = [
  PhoneDataModel(
    id: 0200,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.grey[200],
      'Apple Logo': Colors.black,
      'iPhone Text': Colors.black,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0201,
    colors: {
      'Back Panel': Colors.yellow,
      'Apple Logo': Colors.black,
      'iPhone Text': Colors.black,
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0202,
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.white,
      'Apple Logo': Colors.black,
      'Texts & Markings': Colors.black,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0203,
    colors: {
      'Camera Bump': Colors.white,
      'Back Panel': Colors.white,
      'Apple Logo': Colors.black,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
  PhoneDataModel(
    id: 0204,
    colors: {
      'Camera Bump': Colors.grey[900],
      'Back Panel': Colors.grey[900],
      'Apple Logo': Colors.black,
    },
    textures: {
      'Camera Bump': MyTexture(),
      'Back Panel': MyTexture(),
    },
  ),
];
