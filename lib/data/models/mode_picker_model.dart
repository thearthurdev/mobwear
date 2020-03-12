enum PickerMode { color, texture, image }

class ModePickerModel {
  final PickerMode pickerMode;
  final String modeName;

  ModePickerModel(this.pickerMode, this.modeName);

  static List<ModePickerModel> myPickerModes = [
    ModePickerModel(PickerMode.color, 'COLOR'),
    ModePickerModel(PickerMode.texture, 'TEXTURE'),
    ModePickerModel(PickerMode.image, 'IMAGE'),
  ];
}
