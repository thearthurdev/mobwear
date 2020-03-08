import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class CircleAccentButton extends StatelessWidget {
  final IconData icon;
  final int index;
  final double size;
  final Function onTap;

  const CircleAccentButton({
    @required this.icon,
    this.index,
    this.size,
    this.onTap,
  });

  static int randomInt = Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          width: kScreenAwareSize(size ?? 60.0, context),
          height: kScreenAwareSize(size ?? 60.0, context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.accents[index ?? randomInt].withOpacity(0.4),
          ),
          child: Icon(
            icon,
            size: kScreenAwareSize(25.0, context),
            color: Colors.primaries[index ?? randomInt],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
