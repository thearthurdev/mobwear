import 'package:mobwear/data/models/phone_model.dart';

class SearchItem {
  final dynamic phone;
  final String phoneName;
  final String phoneBrand;
  final int brandIndex;
  final int phoneIndex;
  final int phoneID;

  const SearchItem(
    this.phone,
    this.phoneName,
    this.phoneBrand,
    this.brandIndex,
    this.phoneIndex,
    this.phoneID,
  );

  static List<SearchItem> allSearchItems = [];

  static void getSearchItems() {
    allSearchItems.clear();
    for (List<PhoneModel> phonesList in PhoneModel.phonesLists) {
      for (PhoneModel phoneModel in phonesList) {
        allSearchItems.add(
          SearchItem(
            phoneModel.phone,
            phoneModel.phone.getPhoneName,
            phoneModel.phone.getPhoneBrand,
            phoneModel.phone.getPhoneBrandIndex,
            phoneModel.phone.getPhoneIndex,
            phoneModel.id,
          ),
        );
      }
    }
  }
}
