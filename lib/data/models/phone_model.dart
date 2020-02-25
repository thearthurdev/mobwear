import 'package:mobwear/data/phones/apple/iPhone_phones_list.dart';
import 'package:mobwear/data/phones/google/pixel_phones_list.dart';
import 'package:mobwear/data/phones/samsung/galaxy_phones_list.dart';

class PhoneModel {
  final int id;
  final dynamic phone;

  PhoneModel({this.id, this.phone});

  static List<List<PhoneModel>> phonesLists = [
    pixelPhonesList,
    iPhonePhonesList,
    galaxyPhonesList,
  ];
}
