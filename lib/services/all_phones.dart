import 'package:mobware/data/models/phone_model.dart';
import 'package:mobware/data/models/search_item_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/galaxyList.dart';

List<List<PhoneModel>> phoneLists = [pixelList, iPhoneList, galaxyList];

List<SearchItem> allPhones() {
  List<SearchItem> list = [];
  for (List<PhoneModel> phoneList in phoneLists) {
    for (PhoneModel phoneModel in phoneList) {
      list.add(
        SearchItem(
          phoneModel.phone,
          phoneModel.phone.getPhoneName,
          phoneModel.phone.getPhoneBrand,
          phoneModel.phone.phoneBrandIndex,
          phoneModel.phone.phoneIndex,
        ),
      );
    }
  }
  return list;
}
