import 'package:fonoapi_dart/fonoapi_dart.dart';

const apiToken = '72576cadda0205e850428469f2b7a80e03eba9c3f2b024f4';

List specsList;

class PhoneSpecs {
  Future<List> getPhoneSpecs({String brand, model, device}) async {
    try {
      String token = apiToken;

      final FonoApi fonoApi = FonoApi(token);

      final List<Device> devices = await fonoApi.getDevices(
        brand: brand,
        model: model,
      );

      // specsList.clear();
      // print(specsList);

      devices.forEach((i) {
        if (i.deviceName.contains(device)) {
          specsList = [
            i.batteryC,
            i.cameraC,
            i.memoryC,
            i.the35MmJack,
            i.weight,
            i.displayC,
          ];
        }

        // print(specsList);

        return specsList;
      });
    } catch (e) {
      // print(e);
    }
    return specsList;
  }
}
