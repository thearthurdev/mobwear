import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/adaptive_dialog.dart';
import 'package:provider/provider.dart';

class ColorPickerDialog extends StatelessWidget {
  final String title;
  final Color color;
  final Function onSelectPressed;

  const ColorPickerDialog({
    this.title,
    this.color,
    this.onSelectPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        Color selectedColor = color;

        return AdaptiveDialog(
          title: title,
          maxWidth: 300.0,
          child: SingleChildScrollView(
            child: Center(
              child: CircleColorPicker(
                initialColor: selectedColor,
                size: Size(260.0, 260.0),
                onChanged: (color) => selectedColor = color,
              ),
            ),
          ),
          onSelectPressed: () {
            onSelectPressed(selectedColor);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
