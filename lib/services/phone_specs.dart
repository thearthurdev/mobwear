import 'package:fonoapi_dart/fonoapi_dart.dart';

// https://fonoapi.freshpixl.com/token/generate
const apiToken = 'insert your token from the link above';

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
        return specsList;
      });
    } catch (e) {
      // print(e);
    }
    return specsList;
  }
}
