import 'package:flutter/material.dart';
import 'package:mobware/providers/theme_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class QuickBrigthnessSwitch extends StatefulWidget {
  const QuickBrigthnessSwitch({
    Key key,
  }) : super(key: key);

  @override
  _QuickBrigthnessSwitchState createState() => _QuickBrigthnessSwitchState();
}

class _QuickBrigthnessSwitchState extends State<QuickBrigthnessSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: kThemeBrightness(context) == Brightness.dark ? false : true,
      onChanged: (b) {
        Brightness brightness;
        b = !b;
        if (b) {
          brightness = Brightness.dark;
        } else {
          brightness = Brightness.light;
        }
        setState(() {
          Provider.of<ThemeProvider>(context)
              .changeBrightness(context, brightness);
        });
      },
    );
  }
}
