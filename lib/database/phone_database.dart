import 'package:hive/hive.dart';
import 'package:mobwear/data/models/phone_data_model.dart';

class PhoneDatabase {
  static const String phones = 'phones';

  static var phonesBox = Hive.box(phones);

  static List<List<PhoneDataModel>> phonesDataLists =
      PhoneDataModel.phonesDataLists;

  static Future<dynamic> initPhonesDB(Box phonesBox) async {
    List<PhoneDataModel> allPhoneDataModels = [];

    for (List<PhoneDataModel> phoneDataList in phonesDataLists) {
      for (PhoneDataModel phoneModel in phoneDataList) {
        allPhoneDataModels.add(phoneModel);
      }
    }

    for (PhoneDataModel phoneData in allPhoneDataModels) {
      if (phonesBox.get(phoneData.id) == null) {
        print('adding data model id:${phoneData.id}');
        phonesBox.put(phoneData.id, phoneData);
      }
    }
  }
}
