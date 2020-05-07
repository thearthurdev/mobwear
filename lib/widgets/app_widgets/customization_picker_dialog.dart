import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:mobwear/data/models/mode_picker_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/adaptiveDialog.dart';
import 'package:mobwear/widgets/app_widgets/texture_picker.dart';
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
  bool isCapturePage;
  bool isWideScreen;

  @override
  void initState() {
    super.initState();
    pickerModeIndex = widget.initPickerModeIndex;
    modeCount = getModeCount(widget.noTexture, widget.noImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isCapturePage = Provider.of<CustomizationProvider>(context).isCapturePage;
  }

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) && kDeviceIsLandscape(context);
    Orientation orientation = MediaQuery.of(context).orientation;

    List<Widget> pickerModeViews = [
      ColorPicker(
        color: Provider.of<CustomizationProvider>(context).currentColor ??
            widget.initRandomColor,
        onChanged: (color) =>
            Provider.of<CustomizationProvider>(context, listen: false)
                .colorSelected(color),
      ),
      TexturePicker(),
      Container(
        height: 200.0,
        child: Center(
          child: Text('Image'),
        ),
      ),
    ];

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(
          context,
          lightColor: Color(0xFF757575),
          darkColor:
              isCapturePage && !isWideScreen ? Color(0xFF060606) : Colors.black,
        ),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: DefaultTabController(
        initialIndex: pickerModeIndex,
        length: modeCount,
        child: AdaptiveDialog(
          title: isCapturePage
              ? 'Background'
              : Provider.of<CustomizationProvider>(context).currentSide,
          onSelectPressed: () => onCustomizationSelected(),
          maxWidth: isWideScreen && orientation == Orientation.landscape
              ? 620.0
              : null,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                                  ModePickerModel.myPickerModes[i].modeName,
                                  style: kTitleTextStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                          onTap: (i) => setState(() => pickerModeIndex = i),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
                    child: pickerModeViews[pickerModeIndex],
                  ),
                ],
              ),
            ),
          ),
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
      Provider.of<CustomizationProvider>(context, listen: false)
          .changeColor(widget.noTexture);
    } else if (pickerModeIndex == 1) {
      Provider.of<CustomizationProvider>(context, listen: false)
          .changeTexture();
    }

    Navigator.pop(context);
  }
}
