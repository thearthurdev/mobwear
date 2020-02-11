import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/phones/google/pixel_2.dart';
import 'package:mobware/data/phones/google/pixel_2_xl.dart';
import 'package:mobware/data/phones/google/pixel_3_xl.dart';
import 'package:mobware/data/phones/google/pixel_4_xl.dart';
import 'package:mobware/data/phones/google/pixel_xl.dart';

List<PhoneModel> pixelPhonesList = [
  PhoneModel(
    id: 0100,
    phone: PixelXL(),
  ),
  PhoneModel(
    id: 0101,
    phone: Pixel2(),
  ),
  PhoneModel(
    id: 0102,
    phone: Pixel2XL(),
  ),
  PhoneModel(
    id: 0103,
    phone: Pixel3XL(),
  ),
  PhoneModel(
    id: 0104,
    phone: Pixel4XL(),
  ),
];
