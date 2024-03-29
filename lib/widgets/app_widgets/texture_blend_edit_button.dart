import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/color_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/customization_indicator.dart';
import 'package:mobwear/widgets/app_widgets/elevated_card.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/texture_blend_mode_picker_dialog.dart';
import 'package:provider/provider.dart';

class TextureBlendEditButton extends StatelessWidget {
  final String title, subtitle;

  const TextureBlendEditButton({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        Color blendColor =
            provider.selectedBlendColor ?? provider.currentBlendColor;

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
                title: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                trailing: title == 'Blend Mode'
                    ? null
                    : CustomizationIndicator(
                        color: blendColor,
                        size: kScreenAwareSize(25.0, context),
                      ),
              ),
              onTap: title == 'Blend Mode'
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return TextureBlendModePickerDialog();
                        },
                      );
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ColorPickerDialog(
                            title: 'Blend Color',
                            color: provider.selectedBlendColor ??
                                provider.currentBlendColor,
                            onSelectPressed: (selectedColor) {
                              provider.textureBlendColorSelected(selectedColor);
                            },
                          );
                        },
                      );
                    },
            ),
          ),
        );
      },
    );
  }
}
