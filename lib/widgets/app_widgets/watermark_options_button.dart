import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/color_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/customization_indicator.dart';
import 'package:mobwear/widgets/app_widgets/elevated_card.dart';
import 'package:mobwear/widgets/app_widgets/position_picker_dialog.dart';
import 'package:provider/provider.dart';

class WatermarkOptionsButton extends StatelessWidget {
  final String title, subtitle;
  final Color watermarkColor;

  const WatermarkOptionsButton({
    this.title,
    this.subtitle,
    this.watermarkColor,
  });

  @override
  Widget build(BuildContext context) {
    bool enabled = Provider.of<CustomizationProvider>(context).showWatermark;

    return ElevatedCard(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      color: kBrightnessAwareColor(context,
          lightColor: Colors.white, darkColor: Colors.grey[850]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          child: ListTile(
            dense: true,
            enabled: Provider.of<CustomizationProvider>(context).showWatermark,
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: title == 'Position'
                ? null
                : CustomizationIndicator(
                    color: watermarkColor,
                    size: kScreenAwareSize(25.0, context),
                  ),
          ),
          onTap: enabled
              ? title == 'Position'
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PositionPickerDialog();
                        },
                      );
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ColorPickerDialog(
                            title: 'Color',
                            color: watermarkColor,
                            onSelectPressed: (selectedColor) =>
                                Provider.of<CustomizationProvider>(context)
                                    .watermarkColorSelected(selectedColor),
                          );
                        },
                      );
                    }
              : null,
        ),
      ),
    );
  }
}
