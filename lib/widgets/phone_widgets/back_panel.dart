import 'package:flutter/material.dart';
import 'package:mobware/utils/constants.dart';

class BackPanel extends StatefulWidget {
  final double width, height, cornerRadius, bezelWidth;
  final Color backPanelColor, bezelColor, textureBlendColor;
  final String texture;
  final BlendMode textureBlendMode;
  final Widget child;

  const BackPanel({
    @required this.backPanelColor,
    @required this.bezelColor,
    this.texture,
    this.child,
    this.width = 240.0,
    this.height = 480.0,
    this.cornerRadius = 23.0,
    this.bezelWidth = 1.0,
    this.textureBlendColor,
    this.textureBlendMode,
  });

  @override
  _BackPanelState createState() => _BackPanelState();
}

class _BackPanelState extends State<BackPanel> {
  Matrix4 matrix;

  @override
  void initState() {
    super.initState();
    matrix = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width + 1.2,
      height: widget.height + 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
        color: kThemeBrightness(context) == Brightness.light
            ? Colors.transparent
            : Colors.grey[800],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(5, 5),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.cornerRadius),
            border: Border.all(
              color: widget.bezelColor,
              width: widget.bezelWidth,
            ),
            color: widget.texture == null
                ? widget.backPanelColor
                : Colors.transparent,
            image: widget.texture == null
                ? null
                : DecorationImage(
                    image: AssetImage(widget.texture),
                    fit: BoxFit.cover,
                    colorFilter: widget.textureBlendMode == null
                        ? null
                        : ColorFilter.mode(
                            widget.textureBlendColor,
                            widget.textureBlendMode,
                          ),
                  ),
          ),
          child: widget.child == null ? Container() : widget.child,
        ),
      ),
    );
  }
}
