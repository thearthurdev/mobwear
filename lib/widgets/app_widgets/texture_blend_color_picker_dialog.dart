import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:provider/provider.dart';

class TextureBlendColorPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color selectedColor =
        Provider.of<PhoneCustomizationProvider>(context).currentBlendColor;

    return SimpleDialog(
      titlePadding: EdgeInsets.fromLTRB(20.0, 16.0, 13.0, 0.0),
      title: Row(
        children: <Widget>[
          Text(
            'Blend Color',
          ),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(LineAwesomeIcons.check_circle),
            onPressed: () {
              Provider.of<PhoneCustomizationProvider>(context)
                  .textureBlendColorSelected(selectedColor);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(LineAwesomeIcons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 16.0),
          child: Center(
            child: CircleColorPicker(
              initialColor: Provider.of<PhoneCustomizationProvider>(context)
                  .currentBlendColor,
              size: Size(300.0, 300.0),
              onChanged: (color) => selectedColor = color,
              strokeWidth: 16.0,
            ),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     IconButton(
        //       icon: Icon(LineAwesomeIcons.copy),
        //       onPressed: () {
        //         Clipboard.setData(ClipboardData(
        //             text: selectedColor.toString()));
        //         Toast.show(
        //             'Color copied to clipboard', context);
        //       },
        //     ),
        //     SizedBox(width: 24.0),
        //     IconButton(
        //       icon: Icon(LineAwesomeIcons.paste),
        //       onPressed: () async {
        //         ClipboardData getData =
        //             await Clipboard.getData('text/plain');
        //         String data =
        //             getData.text.split('x')[1].split(')')[0];

        //         // setState(() {
        //         // blendColor = Color.fromARGB(a, r, g, b);
        //         // });
        //       },
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
