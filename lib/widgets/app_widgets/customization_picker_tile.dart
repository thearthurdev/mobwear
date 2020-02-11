import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/data/models/texture_model.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/customization_indicator.dart';
import 'package:mobware/widgets/app_widgets/customization_picker_dialog.dart';
import 'package:mobware/widgets/app_widgets/elevated_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    MyTexture texture = noTexture ? null : textures.values.elementAt(index);
    Color color = colors.values.elementAt(index);

    final SlidableController slidableController = SlidableController();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Slidable(
        controller: slidableController,
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        actions: <Widget>[
          slidableActionButton(
            margin: EdgeInsets.only(right: 8.0),
            context: context,
            caption: 'Reset',
            icon: LineAwesomeIcons.refresh,
            color: kBrightnessAwareColor(context,
                lightColor: Colors.red[800], darkColor: Colors.red[500]),
            onTap: () => onResetPressed(context),
          ),
        ],
        secondaryActions: <Widget>[
          slidableActionButton(
            margin: EdgeInsets.only(left: 8.0),
            context: context,
            caption: 'Copy',
            icon: LineAwesomeIcons.copy,
            color: kBrightnessAwareColor(context,
                lightColor: Colors.green[800], darkColor: Colors.green[500]),
            onTap: () => onCopyPressed(context),
          ),
          slidableActionButton(
            margin: EdgeInsets.only(left: 8.0),
            context: context,
            caption: 'Paste',
            icon: LineAwesomeIcons.copy,
            color: kBrightnessAwareColor(context,
                lightColor: Colors.blue[800], darkColor: Colors.blue[500]),
            onTap: () => onPastePressed(context),
            isEnabled: Provider.of<CustomizationProvider>(context)
                .isCustomizationCopied,
          ),
        ],
        child: ElevatedCard(
          child: ListTile(
            title: Text(colors.keys.elementAt(index), style: kTitleTextStyle),
            subtitle: Text(
              noTexture
                  ? 'Color: #${kGetColorString(color)}'
                  : texture.asset == null
                      ? 'Color: #${kGetColorString(color)}'
                      : 'Texture: ${kGetTextureName(texture.asset)}',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.black54, darkColor: Colors.white54),
              ),
            ),
            trailing: CustomizationIndicator(
              color: color,
              texture: noTexture ? null : texture.asset,
              textureBlendColor: noTexture ? null : texture.blendColor,
              textureBlendMode: noTexture
                  ? null
                  : kGetTextureBlendMode(texture.blendModeIndex),
            ),
            onTap: () => onTilePressed(context),
          ),
        ),
      ),
    );
  }

  ElevatedCard slidableActionButton({
    BuildContext context,
    String caption,
    IconData icon,
    Color color,
    EdgeInsetsGeometry margin,
    Function onTap,
    bool isEnabled = true,
  }) {
    return ElevatedCard(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: IconSlideAction(
          onTap: isEnabled ? onTap : null,
          caption: caption,
          icon: icon,
          color: Colors.transparent,
          foregroundColor: isEnabled
              ? color
              : kBrightnessAwareColor(context,
                  lightColor: Colors.grey[400], darkColor: Colors.grey[600]),
        ),
      ),
    );
  }

  void onTilePressed(BuildContext context) {
    Provider.of<CustomizationProvider>(context).isSharePage = false;
    Provider.of<CustomizationProvider>(context).selectedTexture = null;
    Provider.of<CustomizationProvider>(context).changeCopyStatus(false);
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
        if (Provider.of<CustomizationProvider>(context).currentTexture != null)
          return 1;
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
    ).whenComplete(() {});
  }

  void onResetPressed(BuildContext context) {
    Provider.of<CustomizationProvider>(context).setCurrentSide(index);
    Provider.of<CustomizationProvider>(context).resetCurrentSide(noTexture);
    showSnackBar(context,
        '${Provider.of<CustomizationProvider>(context).currentSide} customization reset');
  }

  void onCopyPressed(BuildContext context) {
    Provider.of<CustomizationProvider>(context).setCurrentSide(index);
    Provider.of<CustomizationProvider>(context).copyCustomization(noTexture);
    showSnackBar(context,
        '${Provider.of<CustomizationProvider>(context).currentSide} customization copied');
  }

  void onPastePressed(BuildContext context) {
    String previousSide =
        Provider.of<CustomizationProvider>(context).currentSide;

    Provider.of<CustomizationProvider>(context).setCurrentSide(index);
    try {
      Provider.of<CustomizationProvider>(context).pasteCustomization(noTexture);
      showSnackBar(
        context,
        '$previousSide customization pasted to ${Provider.of<CustomizationProvider>(context).currentSide}',
      );
    } catch (e) {
      showSnackBar(
        context,
        'Cannot apply texture here',
      );
    }
  }

  void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
          ),
        ),
        backgroundColor: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.grey[900]),
        action: SnackBarAction(
          label: 'Okay',
          textColor: Colors.white,
          onPressed: () => Scaffold.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
