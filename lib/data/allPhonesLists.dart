import 'package:mobware/data/phone_model.dart';
import 'package:mobware/data/phones/apple/iPhoneList.dart';
import 'package:mobware/data/phones/google/pixel_list.dart';
import 'package:mobware/data/phones/samsung/samsungList.dart';

Map<int, List> phoneListsMap = {
  0: pixelList,
  1: iPhoneList,
  2: samsungList,
};

List<PhoneModel> phones = pixelList + iPhoneList + samsungList;

List<SearchItem> allPhones() {
  List<SearchItem> list = [];
  for (PhoneModel phoneModel in phones) {
    list.add(
      SearchItem(
        phoneModel.phone,
        phoneModel.phone.getPhoneName,
        phoneModel.phone.phoneBrandIndex,
        phoneModel.phone.phoneIndex,
      ),
    );
    // print(list);
  }
  return list;
}

class SearchItem {
  final dynamic phone;
  final String phoneName;
  final int brandIndex;
  final int phoneIndex;

  const SearchItem(
    this.phone,
    this.phoneName,
    this.brandIndex,
    this.phoneIndex,
  );
}
