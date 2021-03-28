import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/data/models/brand_model.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/adaptive_dialog.dart';
import 'package:mobwear/widgets/app_widgets/settings_expansion_tile.dart';
import 'package:mobwear/widgets/app_widgets/watermark_options_button.dart';
import 'package:provider/provider.dart';

class WatermarkPickerDialog extends StatefulWidget {
  final Color backgroundColor;
  final MyTexture backgroundTexture;

  const WatermarkPickerDialog({this.backgroundColor, this.backgroundTexture});

  @override
  _WatermarkPickerDialogState createState() => _WatermarkPickerDialogState();
}

class _WatermarkPickerDialogState extends State<WatermarkPickerDialog> {
  bool isTileExpanded = false;
  bool isWideScreen;

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) && kDeviceIsLandscape(context);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575),
            darkColor: isWideScreen ? Colors.black : Color(0xFF060606)),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Consumer<CustomizationProvider>(
        builder: (context, provider, child) {
          Color watermarkColor = provider.selectedWatermarkColor ??
              provider.watermarkColor ??
              kEstimateColorFromColorBrightness(
                widget.backgroundColor,
                lightColor: Colors.white38,
                darkColor: Colors.black38,
              );

          return AdaptiveDialog(
            title: 'Watermark',
            onSelectPressed: () {
              provider.setWatermark();
              Navigator.pop(context);
            },
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SettingsExpansionTile(
                      title: 'Visibilty',
                      subtitle: provider.showWatermark
                          ? 'Watermark will be shown'
                          : 'Watermark will be hidden',
                      isExpanded: isTileExpanded,
                      onExpansionChanged: (b) =>
                          setState(() => isTileExpanded = b),
                      selectedOptionCheck: provider.showWatermark,
                      settingMap: provider.myWatermarkOptions,
                      onOptionSelected: (i) => provider.watermarkStateSelected(
                          provider.myWatermarkOptions.values.elementAt(i)),
                      expandedColor: kBrightnessAwareColor(context,
                          lightColor: Colors.grey[100],
                          darkColor: Colors.black26),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(4.0),
                      constraints: BoxConstraints(maxHeight: 280.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: kBrightnessAwareColor(context,
                              lightColor: Colors.grey[300],
                              darkColor: Colors.grey[800]),
                          width: 0.3,
                        ),
                        color: widget.backgroundTexture.asset == null
                            ? widget.backgroundColor
                            : Colors.transparent,
                        image: widget.backgroundTexture.asset == null
                            ? null
                            : DecorationImage(
                                image:
                                    AssetImage(widget.backgroundTexture.asset),
                                fit: BoxFit.cover,
                                colorFilter:
                                    widget.backgroundTexture.blendModeIndex ==
                                            null
                                        ? null
                                        : ColorFilter.mode(
                                            widget.backgroundTexture.blendColor,
                                            kGetTextureBlendMode(widget
                                                .backgroundTexture
                                                .blendModeIndex),
                                          ),
                              ),
                      ),
                      child: Scrollbar(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: BrandIcon.watermarkIcons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isWideScreen ? 6 : 4,
                          ),
                          itemBuilder: (context, i) {
                            BrandIcon watermarkIcon =
                                BrandIcon.watermarkIcons[i];

                            return watermarkIconButton(
                              color: watermarkColor,
                              icon: watermarkIcon.icon,
                              iconSize: watermarkIcon.size,
                              isSelected:
                                  provider.selectedWatermarkIndex == null
                                      ? provider.watermarkIndex == i
                                      : provider.selectedWatermarkIndex == i,
                              onTap: () => provider.watermarkIndexSelected(i),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: WatermarkOptionsButton(
                              title: 'Position',
                              subtitle: MyPosition
                                  .myPositions[provider.watermarkPositionIndex]
                                  .name,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          Expanded(
                            child: WatermarkOptionsButton(
                              title: 'Color',
                              subtitle:
                                  '#${kGetColorString(watermarkColor ?? Colors.deepOrange)}',
                              watermarkColor: watermarkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget watermarkIconButton({
    Color color,
    IconData icon,
    double iconSize,
    bool isSelected,
    Function onTap,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(kScreenAwareSize(8.0, context)),
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: color,
                      width: 2.0,
                    ),
                  )
                : null,
            child: Icon(
              icon,
              size: iconSize == null ? 30.0 : iconSize + 3.0,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
