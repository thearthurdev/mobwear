import 'package:flutter/material.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/color_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/customization_indicator.dart';
import 'package:mobwear/widgets/app_widgets/elevated_card.dart';
import 'package:mobwear/widgets/app_widgets/texture_blend_mode_picker_dialog.dart';
import 'package:provider/provider.dart';

class TextureBlendEditButton extends StatelessWidget {
  final String title, subtitle;

  const TextureBlendEditButton({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        String selectedTexture = provider.selectedTexture;
        String currentTexture = provider.currentTexture;
        Color blendColor =
            provider.selectedBlendColor ?? provider.currentBlendColor;

        return ElevatedCard(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          color: kBrightnessAwareColor(context,
              lightColor: Colors.white, darkColor: Colors.grey[850]),
          child: ListTile(
            enabled: selectedTexture != null
                ? true
                : currentTexture != null ? true : false,
            dense: true,
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
            trailing: title == 'Blend Mode'
                ? null
                : CustomizationIndicator(
                    color: blendColor,
                    size: kScreenAwareSize(25.0, context),
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
                          onSelectPressed: (selectedColor) =>
                              provider.textureBlendColorSelected(selectedColor),
                        );
                      },
                    );
                  },
          ),
        );
      },
    );
  }
}
