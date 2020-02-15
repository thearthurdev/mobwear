import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/data/models/brand_icon_model.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kThemeBrightness(context) == Brightness.light
            ? Color(0xFF757575)
            : Color(0xFF060606),
        systemNavigationBarIconBrightness: Brightness.dark,
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

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 8.0, 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Watermark',
                        style: kTitleTextStyle.copyWith(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                SettingsExpansionTile(
                  title: 'Visibilty',
                  subtitle: provider.showWatermark
                      ? 'Watermark will be shown'
                      : 'Watermark will be hidden',
                  isExpanded: isTileExpanded,
                  onExpansionChanged: (b) => setState(() => isTileExpanded = b),
                  selectedOptionCheck: provider.showWatermark,
                  settingMap: provider.myWatermarkOptions,
                  onOptionSelected: (i) => provider.watermarkStateSelected(
                      provider.myWatermarkOptions.values.elementAt(i)),
                  expandedColor: kBrightnessAwareColor(context,
                      lightColor: Colors.grey[100], darkColor: Colors.black26),
                ),
                Container(
                  height: kScreenAwareSize(220.0, context),
                  margin: EdgeInsets.all(8.0),
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
                            image: AssetImage(widget.backgroundTexture.asset),
                            fit: BoxFit.cover,
                            colorFilter:
                                widget.backgroundTexture.blendModeIndex == null
                                    ? null
                                    : ColorFilter.mode(
                                        widget.backgroundTexture.blendColor,
                                        kGetTextureBlendMode(widget
                                            .backgroundTexture.blendModeIndex),
                                      ),
                          ),
                  ),
                  child: GridView.builder(
                    itemCount: BrandIcon.watermarkIcons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, i) {
                      BrandIcon watermarkIcon = BrandIcon.watermarkIcons[i];

                      return watermarkIconButton(
                        color: watermarkColor,
                        icon: watermarkIcon.icon,
                        iconSize: watermarkIcon.size,
                        isSelected: provider.selectedWatermarkIndex == null
                            ? provider.watermarkIndex == i
                            : provider.selectedWatermarkIndex == i,
                        onTap: () => provider.watermarkIndexSelected(i),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: WatermarkOptionsButton(
                          title: 'Position',
                          subtitle: Position
                              .myPositions[provider.watermarkPositionIndex]
                              .name,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: WatermarkOptionsButton(
                          title: 'Color',
                          subtitle: '#${kGetColorString(Colors.deepOrange)}',
                          watermarkColor: watermarkColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  buttonTextTheme: ButtonTextTheme.normal,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Cancel', style: kTitleTextStyle),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text('Select', style: kTitleTextStyle),
                      onPressed: () {
                        provider.setWatermark();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
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
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
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
            size: iconSize == null ? 30.0 : iconSize + 6.0,
            color: color,
          ),
        ),
      ),
    );
  }
}
