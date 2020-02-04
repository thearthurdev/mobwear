import 'package:flutter/material.dart';
import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/data/phones/apple/11.dart';
import 'package:mobware/data/phones/apple/11ProMax.dart';
import 'package:mobware/data/phones/apple/8Plus.dart';
import 'package:mobware/data/phones/apple/xr.dart';
import 'package:mobware/data/phones/apple/xsMax.dart';

List<PhoneModel> iPhoneList = [
  PhoneModel(
    id: 0200,
    phone: IPhone8Plus(),
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
  PhoneModel(
    id: 0201,
    phone: IPhoneXR(),
    colors: {
      'Back Panel': Colors.yellow,
      'Apple Logo': Colors.black,
      'iPhone Text': Colors.black,
    },
    textures: {
      'Back Panel': MyTexture(),
    },
  ),
  PhoneModel(
    id: 0202,
    phone: IPhoneXSMax(),
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
  PhoneModel(
    id: 0203,
    phone: IPhone11(),
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
  PhoneModel(
    id: 0204,
    phone: IPhone11ProMax(),
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
