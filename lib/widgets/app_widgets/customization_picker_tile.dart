import 'package:flutter/material.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/customization_indicator.dart';
import 'package:mobware/widgets/app_widgets/customization_picker_dialog.dart';
import 'package:mobware/widgets/app_widgets/elevated_card.dart';
import 'package:provider/provider.dart';

class CustomizationPickerTile extends StatelessWidget {
  final Map colors;
  final Map textures;
  final int index;
  final bool noTexture;

  const CustomizationPickerTile({
    this.colors,
    this.textures,
    this.index,
    this.noTexture,
  });

  @override
  Widget build(BuildContext context) {
    // int initIndex = 0;

    return ElevatedCard(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: ListTile(
        title: Text(colors.keys.elementAt(index), style: kTitleTextStyle),
        subtitle: Text(
          noTexture
              ? 'Color: #${kGetColorString(colors.values.elementAt(index))}'
              : textures.values.elementAt(index).asset == null
                  ? 'Color: #${kGetColorString(colors.values.elementAt(index))}'
                  : 'Texture: ${kGetTextureName(textures.values.elementAt(index).asset)}',
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: kBrightnessAwareColor(context,
                lightColor: Colors.black54, darkColor: Colors.white54),
          ),
        ),
        trailing: CustomizationIndicator(
          color: colors.values.elementAt(index),
          texture: noTexture ? null : textures.values.elementAt(index).asset,
          textureBlendColor:
              noTexture ? null : textures.values.elementAt(index).blendColor,
          textureBlendMode:
              noTexture ? null : textures.values.elementAt(index).blendMode,
        ),
        onTap: () {
          Provider.of<CustomizationProvider>(context).isSharePage = false;
          Provider.of<CustomizationProvider>(context).selectedTexture = null;
          Provider.of<CustomizationProvider>(context).setCurrentSide(index);
          Provider.of<CustomizationProvider>(context).getCurrentColor(index);
          Provider.of<CustomizationProvider>(context).resetSelectedValues();

          if (!noTexture)
            Provider.of<CustomizationProvider>(context)
                .getCurrentSideTextureDetails(i: index);

          int initIndex() {
            if (noTexture) {
              return 0;
            } else {
              if (Provider.of<CustomizationProvider>(context).currentTexture !=
                  null) return 1;
            }
            return 0;
          }

          showDialog<Widget>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: CustomizationPickerDialog(
                noTexture: noTexture,
                initPickerModeIndex: initIndex(),
              ),
            ),
          );
        },
        // onExpansionChanged: (b) {
        //   if (b) {
        //     Provider.of<CustomizationProvider>(context).isSharePage = false;
        //     Provider.of<CustomizationProvider>(context).selectedTexture = null;
        //     Provider.of<CustomizationProvider>(context).setCurrentSide(index);
        //     Provider.of<CustomizationProvider>(context).getCurrentColor(index);
        //     Provider.of<CustomizationProvider>(context).resetSelectedValues();

        //     if (!noTexture)
        //       Provider.of<CustomizationProvider>(context)
        //           .getCurrentSideTextureDetails(i: index);

        //     if (noTexture) {
        //       initIndex = 0;
        //     } else {
        //       if (Provider.of<CustomizationProvider>(context).currentTexture !=
        //           null) initIndex = 1;
        //     }
        //   }
        // },
        // children: <Widget>[
        //   CustomizationPickerDialog(
        //     noTexture: noTexture,
        //     initPickerModeIndex: initIndex,
        //   ),
        // ],
      ),
    );
  }
}
