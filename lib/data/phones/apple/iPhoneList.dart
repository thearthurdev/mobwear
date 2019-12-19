import 'package:flutter/material.dart';
import 'package:mobware/data/phone_model.dart';
import 'package:mobware/data/phones/apple/11.dart';
import 'package:mobware/data/phones/apple/11ProMax.dart';
import 'package:mobware/data/phones/apple/8Plus.dart';
import 'package:mobware/data/phones/apple/xr.dart';
import 'package:mobware/data/phones/apple/xsMax.dart';

List<PhoneModel> iPhoneList = [
  PhoneModel(
    phone: IPhone8Plus(),
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.pink[100],
      'Apple Logo': Colors.black,
      'iPhone Text': Colors.black,
    },
  ),
  PhoneModel(
    phone: IPhoneXR(),
    colors: {
      'Back Panel': Colors.yellow,
      'Apple Logo': Colors.black,
      'iPhone Text': Colors.black,
    },
  ),
  PhoneModel(
    phone: IPhoneXSMax(),
    colors: {
      'Camera Bump': Colors.black,
      'Back Panel': Colors.white,
      'Apple Logo': Colors.black,
      'Texts & Markings': Colors.black,
    },
  ),
  PhoneModel(
    phone: IPhone11(),
    colors: {
      'Camera Bump': Colors.white,
      'Back Panel': Colors.white,
      'Apple Logo': Colors.black,
    },
  ),
  PhoneModel(
    phone: IPhone11ProMax(),
    colors: {
      'Camera Bump': Colors.grey[900],
      'Back Panel': Colors.grey[900],
      'Apple Logo': Colors.black,
    },
  ),
];
