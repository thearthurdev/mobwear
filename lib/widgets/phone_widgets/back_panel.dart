import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';

class BackPanel extends StatefulWidget {
  final double width, height, cornerRadius, bezelsWidth;
  final Color backPanelColor, bezelsColor, textureBlendColor;
  final List<Widget> leftButtons, rightButtons, topButtons;
  final BorderRadiusGeometry borderRadius;
  final String texture;
  final BlendMode textureBlendMode;
  final BoxFit textureFit;
  final Widget child;
  final bool noShadow, noButtons;

  const BackPanel({
    @required this.backPanelColor,
    this.bezelsColor = Colors.transparent,
    this.texture,
    this.child,
    this.borderRadius,
    this.width = 240.0,
    this.height = 480.0,
    this.cornerRadius = 23.0,
    this.bezelsWidth = 1.0,
    this.noShadow = false,
    this.noButtons = false,
    this.textureBlendColor,
    this.textureBlendMode,
    this.textureFit,
    this.leftButtons,
    this.rightButtons,
    this.topButtons,
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
    if (widget.noButtons) return backPanel(context);

    return Column(
      children: <Widget>[
        topButtons(widget.topButtons),
        Row(
          children: <Widget>[
            sideButtons(widget.leftButtons),
            backPanel(context),
            sideButtons(widget.rightButtons),
          ],
        ),
      ],
    );
  }

  Widget backPanel(BuildContext context) {
    return Container(
      width: widget.width + 1.2,
      height: widget.height + 1.2,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius == null
            ? BorderRadius.circular(widget.cornerRadius)
            : widget.borderRadius,
        color: kThemeBrightness(context) == Brightness.light || widget.noShadow
            ? widget.noShadow ? Colors.transparent : widget.bezelsColor
            : widget.bezelsColor == null ||
                    widget.bezelsColor == Colors.black ||
                    widget.bezelsColor.alpha < 20
                ? Colors.grey[850]
                : widget.bezelsColor,
        boxShadow: widget.noShadow
            ? null
            : [
                BoxShadow(
                  color: kBrightnessAwareColor(context,
                      lightColor: Colors.blueGrey.withOpacity(0.2),
                      darkColor: Colors.black26),
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
          child: widget.child == null ? Container() : widget.child,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius == null
                ? BorderRadius.circular(widget.cornerRadius)
                : widget.borderRadius,
            border: Border.all(
              color: widget.bezelsColor,
              width: widget.bezelsWidth,
            ),
            color:
                widget.texture == null ? widget.backPanelColor : Colors.black,
            image: widget.texture == null
                ? null
                : DecorationImage(
                    image: AssetImage(widget.texture),
                    fit: widget.textureFit ?? BoxFit.cover,
                    colorFilter: widget.textureBlendMode == null
                        ? null
                        : ColorFilter.mode(
                            widget.textureBlendColor,
                            widget.textureBlendMode,
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget sideButtons(List<Widget> buttons) {
    return buttons != null && !widget.noButtons
        ? Container(
            height: widget.height,
            child: Stack(
              children: buttons,
            ),
          )
        : SizedBox();
  }

  Widget topButtons(List<Widget> buttons) {
    return buttons != null && !widget.noButtons
        ? Container(
            width: widget.width,
            child: Stack(
              children: buttons,
            ),
          )
        : SizedBox();
  }
}
