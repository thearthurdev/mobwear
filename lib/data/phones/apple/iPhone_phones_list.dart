import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/data/phones/apple/11.dart';
import 'package:mobwear/data/phones/apple/11ProMax.dart';
import 'package:mobwear/data/phones/apple/8Plus.dart';
import 'package:mobwear/data/phones/apple/xr.dart';
import 'package:mobwear/data/phones/apple/xsMax.dart';

List<PhoneModel> iPhonePhonesList = [
  PhoneModel(
    id: 0200,
    phone: IPhone8Plus(),
  ),
  PhoneModel(
    id: 0201,
    phone: IPhoneXR(),
  ),
  PhoneModel(
    id: 0202,
    phone: IPhoneXSMax(),
  ),
  PhoneModel(
    id: 0203,
    phone: IPhone11(),
  ),
  PhoneModel(
    id: 0204,
    phone: IPhone11ProMax(),
  ),
];
