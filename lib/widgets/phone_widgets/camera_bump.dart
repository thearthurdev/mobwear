import 'package:flutter/material.dart';

class CameraBump extends StatelessWidget {
  final double width, height, cornerRadius, cameraBumpPartsPadding, borderWidth;
  final Color cameraBumpColor, backPanelColor, borderColor, textureBlendColor;
  final String texture;
  final BlendMode textureBlendMode;
  final List<Widget> cameraBumpParts;
  final bool isMatte;

  const CameraBump({
    @required this.width,
    @required this.height,
    @required this.backPanelColor,
    @required this.cameraBumpParts,
    this.texture,
    this.cameraBumpColor = Colors.teal,
    this.cameraBumpPartsPadding = 20.0,
    this.cornerRadius = 20.0,
    this.isMatte = false,
    this.borderWidth = 0.0,
    this.borderColor,
    this.textureBlendColor = Colors.transparent,
    this.textureBlendMode = BlendMode.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
          color: texture == null ? cameraBumpColor : Colors.transparent,
          image: texture == null
              ? null
              : DecorationImage(
                  image: AssetImage(texture),
                  colorFilter: textureBlendMode == null
                      ? null
                      : ColorFilter.mode(
                          textureBlendColor,
                          textureBlendMode,
                        ),
                  fit: BoxFit.cover,
                ),
          boxShadow: cameraBumpColor.alpha < 160
              ? null
              : [
                  BoxShadow(
                    color: backPanelColor.computeLuminance() > 0.335
                        ? Colors.black12
                        : Colors.black38,
                    spreadRadius: 1.0,
                    blurRadius: 3.0,
                  ),
                ]),
      child: FittedBox(
        child: Stack(
          children: <Widget>[
            Container(
              width: width - cameraBumpPartsPadding,
              height: height - cameraBumpPartsPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius - 4.0),
                gradient: cameraBumpColor.alpha == 0
                    ? null
                    : isMatte
                        //Matte Effect
                        ? LinearGradient(
                            colors: [
                              Colors.transparent,
                              backPanelColor.computeLuminance() > 0.335
                                  ? Colors.black12
                                  : Colors.black26
                            ],
                            begin: FractionalOffset(0.5, 0.0),
                            end: FractionalOffset(0.0, 0.5),
                          )
                        //Glossy Effect
                        : LinearGradient(
                            colors: [
                              Colors.transparent,
                              cameraBumpColor.computeLuminance() > 0.335
                                  ? Colors.black.withOpacity(0.05)
                                  : Colors.black.withOpacity(0.15),
                            ],
                            stops: [0.2, 0.2],
                            begin: FractionalOffset(0.5, 0.3),
                            end: FractionalOffset(0.0, 0.5),
                          ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: cameraBumpParts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
