import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class TextureBlendModePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        int blendModeIndex = kGetTextureBlendModeIndex(
            provider.selectedBlendMode ?? provider.currentBlendMode);

        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Blend Mode',
                style: kTitleTextStyle.copyWith(fontSize: 18.0),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: kDeviceWidth(context) - 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: myBlendModes.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                    title: Text(myBlendModes[i].name),
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
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonTextTheme: ButtonTextTheme.normal,
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: kTitleTextStyle),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
