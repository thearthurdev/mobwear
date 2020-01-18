import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/data/models/blend_mode_model.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class TextureBlendModePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int blendModeIndex = kGetTextureBlendModeIndex(
        Provider.of<PhoneCustomizationProvider>(context).currentBlendMode);

    return SimpleDialog(
      titlePadding: EdgeInsets.fromLTRB(20.0, 16.0, 13.0, 0.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Blend Mode',
          ),
          IconButton(
            icon: Icon(LineAwesomeIcons.close),
            onPressed: () => Navigator.pop(context),
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
                            lightColor: Colors.black, darkColor: Colors.white),
                      )
                    : null,
                onTap: () {
                  Provider.of<PhoneCustomizationProvider>(context)
                      .textureBlendModeIndexSelected(i);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
