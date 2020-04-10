import 'package:mobwear/data/phones/apple/iPhone_phones_list.dart';
import 'package:mobwear/data/phones/google/pixel_phones_list.dart';
import 'package:mobwear/data/phones/samsung/galaxy_phones_list.dart';

class PhoneModel {
  final int id;
  final dynamic phone;

  PhoneModel({this.id, this.phone});

  static List<List<PhoneModel>> phonesLists = [
    iPhonePhonesList,
    pixelPhonesList,
    galaxyPhonesList,
  ];

  static List<String> excuses = [
    'Probably due to shipping delays',
    'Check back soon',
    'They might arrive in next update',
    'Try the other available brands',
    'Oops, let\'s wait a while longer',
    'Manufacturing takes time, sadly',
    'ETA unknown, but arrive they shall',
    'They\'ll be in soon'
  ];
}
