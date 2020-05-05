import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/blend_mode_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/adaptiveDialog.dart';
import 'package:provider/provider.dart';

class TextureBlendModePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        int blendModeIndex =
            provider.selectedBlendModeIndex ?? provider.currentBlendModeIndex;

        return AdaptiveDialog(
          title: 'Blend Mode',
          hasSelectButton: false,
          maxWidth: 300.0,
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: MyBlendMode.myBlendModes.length,
              itemBuilder: (context, i) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text(MyBlendMode.myBlendModes[i].name),
                  trailing: blendModeIndex == i
                      ? Icon(
                          LineAwesomeIcons.check_circle,
                          color: kBrightnessAwareColor(context,
                              lightColor: Colors.black,
                              darkColor: Colors.white),
                        )
                      : null,
                  onTap: () {
                    provider.textureBlendModeIndexSelected(i);
                    Navigator.pop(context);
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
