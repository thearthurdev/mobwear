import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:mobware/data/models/mode_picker_model.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:mobware/providers/share_phone_page_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/mode_picker_button.dart';
import 'package:mobware/widgets/app_widgets/texture_picker.dart';
import 'package:provider/provider.dart';

class CustomizationPickerDialog extends StatefulWidget {
  final int initPickerModeIndex;
  final bool noTexture;
  final bool noImage;
  final bool isSharePage;

  const CustomizationPickerDialog({
    this.initPickerModeIndex,
    this.noTexture = true,
    this.noImage = true,
    this.isSharePage = false,
  });

  @override
  _CustomizationPickerDialogState createState() =>
      _CustomizationPickerDialogState();
}

class _CustomizationPickerDialogState extends State<CustomizationPickerDialog> {
  int pickerModeIndex;
  PhoneCustomizationProvider phoneCustomizationProvider;

  @override
  void initState() {
    super.initState();
    pickerModeIndex = widget.initPickerModeIndex;
  }

  @override
  Widget build(BuildContext context) {
    phoneCustomizationProvider =
        Provider.of<PhoneCustomizationProvider>(context);

    List<Widget> pickerModeViews = [
      ColorPicker(
        color: widget.isSharePage
            ? Provider.of<SharePhonePageProvider>(context).backgroundColor
            : phoneCustomizationProvider.currentColor,
        onChanged: (color) => widget.isSharePage
            ? Provider.of<SharePhonePageProvider>(context).colorSelected(color)
            : phoneCustomizationProvider.colorSelected(color),
      ),
      TexturePicker(),
      Container(
        height: 200.0,
        child: Center(
          child: Text('Image'),
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Pick ${pickerModes[pickerModeIndex].modeName}',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                    subtitle: Text(
                      widget.isSharePage
                          ? 'Background'
                          : phoneCustomizationProvider.currentSide,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: kBrightnessAwareColor(context,
                            lightColor: Colors.black54,
                            darkColor: Colors.white54),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        modeCount(widget.noTexture, widget.noImage),
                        (i) {
                          return ModePickerButton(
                            pickerMode: pickerModes[i].pickerMode,
                            icon: pickerModes[i].icon,
                            isSelected: pickerModeIndex == i,
                            onTap: () {
                              setState(() {
                                pickerModeIndex = i;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: pickerModeViews[pickerModeIndex],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonTextTheme: ButtonTextTheme.normal,
            children: <Widget>[
              FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                onPressed: () => onCustomizationSelected(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int modeCount(bool noTexture, noImage) {
    if (noTexture && noImage) return 1;
    if (!noTexture && noImage) return 2;
    return 3;
  }

  void onCustomizationSelected() {
    if (widget.isSharePage) {
      Provider.of<SharePhonePageProvider>(context).changeBackroundColor();
    } else {
      if (pickerModeIndex == 0) {
        phoneCustomizationProvider.changeColor(widget.noTexture);
      } else if (pickerModeIndex == 1) {
        phoneCustomizationProvider.changeTexture();
      }
    }
    Navigator.pop(context);
  }
}
