import 'package:flutter/material.dart';
import 'package:mobwear/providers/theme_provider.dart';
import 'package:mobwear/utils/constants.dart';
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
        b = !b;
        int i = b ? 1 : 0;
        setState(() {
          Provider.of<ThemeProvider>(context, listen: false)
              .changeTheme(context, i);
        });
      },
    );
  }
}
