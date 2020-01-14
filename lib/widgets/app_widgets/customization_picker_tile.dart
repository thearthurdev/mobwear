import 'package:flutter/material.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomizationPickerTile extends StatelessWidget {
  final Map colors;
  final int index;

  const CustomizationPickerTile(this.colors, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: kThemeBrightness(context) == Brightness.light
            ? Colors.white
            : Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: kThemeBrightness(context) == Brightness.light
                ? Colors.black12
                : Colors.black26,
            blurRadius: 10.0,
            offset: Offset(5.0, 6.0),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(colors.keys.elementAt(index), style: kTitleTextStyle),
        subtitle: Text(
          'Color: #${kGetColorString(colors.values.elementAt(index))}',
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: kBrightnessAwareColor(context,
                lightColor: Colors.black54, darkColor: Colors.white54),
          ),
        ),
        trailing: ColorIndicator(color: colors.values.elementAt(index)),
        onTap: () async {
          Provider.of<PhonesData>(context).changeColor(
            context: context,
            colors: colors,
            side: colors.keys.elementAt(index),
            selectedColor: colors.values.elementAt(index),
            selectedSide: colors.keys.elementAt(index),
            index: index,
          );
        },
      ),
    );
  }
}

class ColorIndicator extends StatelessWidget {
  final Color color;
  final double size;

  const ColorIndicator({this.color, this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? kScreenAwareSize(40.0, context),
      height: size ?? kScreenAwareSize(40.0, context),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: kBrightnessAwareColor(context,
              lightColor: Colors.grey[300], darkColor: Colors.grey[800]),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
            colors: [
              color.computeLuminance() > 0.335
                  ? Colors.black.withOpacity(0.15)
                  : Colors.white.withOpacity(0.2),
              Colors.transparent
            ],
            stops: [0.2, 0.2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
    );
  }
}
