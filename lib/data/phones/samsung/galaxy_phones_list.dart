import 'package:mobwear/data/models/phone_model.dart';
import 'package:mobwear/data/phones/samsung/fold.dart';
import 'package:mobwear/data/phones/samsung/note_10_Plus.dart';
import 'package:mobwear/data/phones/samsung/note_7.dart';
import 'package:mobwear/data/phones/samsung/note_8.dart';
import 'package:mobwear/data/phones/samsung/note_9.dart';
import 'package:mobwear/data/phones/samsung/s10_e.dart';
import 'package:mobwear/data/phones/samsung/s10_plus.dart';
import 'package:mobwear/data/phones/samsung/s6.dart';
import 'package:mobwear/data/phones/samsung/s7.dart';
import 'package:mobwear/data/phones/samsung/s8_plus.dart';
import 'package:mobwear/data/phones/samsung/s9.dart';
import 'package:mobwear/data/phones/samsung/s9_plus.dart';

List<PhoneModel> galaxyPhonesList = [
  PhoneModel(id: 0200, phone: S6()),
  PhoneModel(id: 0201, phone: S7()),
  PhoneModel(id: 0202, phone: Note7()),
  PhoneModel(id: 0203, phone: S8Plus()),
  PhoneModel(id: 0204, phone: Note8()),
  PhoneModel(id: 0205, phone: S9()),
  PhoneModel(id: 0206, phone: S9Plus()),
  PhoneModel(id: 0207, phone: Note9()),
  PhoneModel(id: 0208, phone: S10E()),
  PhoneModel(id: 0209, phone: S10Plus()),
  PhoneModel(id: 0210, phone: Note10Plus()),
  PhoneModel(id: 0211, phone: Fold()),
];
