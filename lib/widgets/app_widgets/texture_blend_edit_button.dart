import 'package:flutter/material.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/customization_indicator.dart';
import 'package:mobware/widgets/app_widgets/elevated_card.dart';
import 'package:mobware/widgets/app_widgets/texture_blend_color_picker_dialog.dart';
import 'package:mobware/widgets/app_widgets/texture_blend_mode_picker_dialog.dart';
import 'package:provider/provider.dart';

class TextureBlendEditButton extends StatelessWidget {
  final String title, subtitle;

  const TextureBlendEditButton({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    String selectedTexture =
        Provider.of<PhoneCustomizationProvider>(context).selectedTexture;
    String currentTexture =
        Provider.of<PhoneCustomizationProvider>(context).currentTexture;
    Color blendColor =
        Provider.of<PhoneCustomizationProvider>(context).currentBlendColor;

    return ElevatedCard(
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
        subtitle: Text(subtitle),
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
                    return TextureBlendColorPickerDialog();
                  },
                );
              },
      ),
    );
  }
}
