import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/data/models/mode_picker_model.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/texture_picker.dart';
import 'package:provider/provider.dart';

class CustomizationPickerDialog extends StatefulWidget {
  final int initPickerModeIndex;
  final Color initRandomColor;
  final bool noTexture;
  final bool noImage;

  const CustomizationPickerDialog({
    this.initPickerModeIndex,
    this.initRandomColor,
    this.noTexture = true,
    this.noImage = true,
  });

  @override
  _CustomizationPickerDialogState createState() =>
      _CustomizationPickerDialogState();
}

class _CustomizationPickerDialogState extends State<CustomizationPickerDialog> {
  int pickerModeIndex;
  int modeCount;
  bool isSharePage;
  dynamic provider;

  @override
  void initState() {
    super.initState();
    pickerModeIndex = widget.initPickerModeIndex;
    modeCount = getModeCount(widget.noTexture, widget.noImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isSharePage = Provider.of<CustomizationProvider>(context).isSharePage;
    provider = Provider.of<CustomizationProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pickerModeViews = [
      ColorPicker(
        color: provider.currentColor ?? widget.initRandomColor,
        onChanged: (color) => provider.colorSelected(color),
      ),
      TexturePicker(),
      Container(
        height: 200.0,
        child: Center(
          child: Text('Image'),
        ),
      ),
    ];

    return DefaultTabController(
      initialIndex: pickerModeIndex,
      length: modeCount,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 4.0),
              child: Row(
                children: <Widget>[
                  Text(
                    isSharePage ? 'Background' : provider.currentSide,
                    style: kTitleTextStyle.copyWith(fontSize: 18.0),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    icon: Icon(LineAwesomeIcons.check_circle),
                    onPressed: () => onCustomizationSelected(),
                  ),
                  IconButton(
                    icon: Icon(LineAwesomeIcons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            modeCount > 1
                ? TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: kBrightnessAwareColor(
                      context,
                      lightColor: Colors.black,
                      darkColor: Colors.white,
                    ),
                    unselectedLabelColor: kBrightnessAwareColor(
                      context,
                      lightColor: Colors.black38,
                      darkColor: Colors.white38,
                    ),
                    tabs: List.generate(
                      modeCount,
                      (i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            pickerModes[i].modeName.split(' ')[1].toUpperCase(),
                            style: kTitleTextStyle,
                          ),
                        );
                      },
                    ),
                    onTap: (i) => setState(() => pickerModeIndex = i),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 20.0),
              child: pickerModeViews[pickerModeIndex],
            ),
          ],
        ),
      ),
    );
  }

  int getModeCount(bool noTexture, noImage) {
    if (noTexture && noImage) return 1;
    if (!noTexture && noImage) return 2;
    return 3;
  }

  void onCustomizationSelected() {
    if (pickerModeIndex == 0) {
      provider.changeColor(widget.noTexture);
    } else if (pickerModeIndex == 1) {
      provider.changeTexture();
    }

    Navigator.pop(context);
  }
}
