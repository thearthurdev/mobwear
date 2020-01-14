import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:mobware/data/models/mode_picker_model.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/mode_picker_button.dart';
import 'package:provider/provider.dart';

class CustomizationPickerDialog extends StatefulWidget {
  final BuildContext context;
  final Color selectedColor;
  final String selectedSide;
  final Color colorPicked;
  final Map colors;
  final int i;

  const CustomizationPickerDialog(
    this.context,
    this.selectedColor,
    this.selectedSide,
    this.colorPicked,
    this.colors,
    this.i,
  );

  @override
  _CustomizationPickerDialogState createState() =>
      _CustomizationPickerDialogState();
}

class _CustomizationPickerDialogState extends State<CustomizationPickerDialog> {
  Color colorPicked;
  int pickerModeIndex = 0;
  TextEditingController textFieldController;

  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController(
        text: '#${kGetColorString(widget.selectedColor)}');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pickerModeViews = [
      ColorPicker(
        color: widget.selectedColor,
        onChanged: (color) {
          colorPicked = color;
        },
      ),
      // Container(
      //   height: 200.0,
      //   child: Center(
      //     child: Text('Image'),
      //   ),
      // ),
      // Container(
      //   height: 200.0,
      //   child: Center(
      //     child: Text('Texture'),
      //   ),
      // ),
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      'Pick ${pickerModes[pickerModeIndex].pickerMode.toString().substring(11)} for',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                    subtitle: Text(
                      widget.selectedSide,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: kBrightnessAwareColor(context,
                            lightColor: Colors.black54,
                            darkColor: Colors.white54),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        pickerModes.length,
                        (i) {
                          return ModePickerButton(
                            pickerMode: pickerModes[i].pickerMode,
                            icon: pickerModes[i].icon,
                            isSelected: pickerModeIndex == i,
                            onTap: () {
                              // setState(() {
                              //   pickerModeIndex = i;
                              // });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: pickerModeViews[pickerModeIndex]),
          SizedBox(height: 8.0),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonTextTheme: ButtonTextTheme.normal,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                onPressed: () {
                  if (colorPicked != null) {
                    widget.colors[widget.colors.keys.elementAt(widget.i)] =
                        colorPicked;
                  } else {
                    widget.colors[widget.colors.keys.elementAt(widget.i)] =
                        widget.selectedColor;
                  }
                  Provider.of<PhonesData>(context).notify();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
