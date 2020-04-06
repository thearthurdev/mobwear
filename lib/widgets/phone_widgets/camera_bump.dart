import 'package:flutter/material.dart';

class CameraBump extends StatelessWidget {
  final double width,
      height,
      cornerRadius,
      effectCornerRadius,
      cameraBumpPartsPadding,
      borderWidth;
  final double elevationSpreadRadius, elevationBlurRadius;
  final Color cameraBumpColor, backPanelColor, borderColor, textureBlendColor;
  final String texture;
  final BlendMode textureBlendMode;
  final List<Widget> cameraBumpParts;
  final bool hasElevation, isMatte;

  const CameraBump({
    @required this.width,
    @required this.height,
    @required this.backPanelColor,
    @required this.cameraBumpParts,
    this.texture,
    this.cameraBumpColor = Colors.teal,
    this.cameraBumpPartsPadding = 20.0,
    this.cornerRadius = 20.0,
    this.effectCornerRadius = 20.0,
    this.elevationSpreadRadius,
    this.elevationBlurRadius,
    this.hasElevation = true,
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
        boxShadow: cameraBumpColor.alpha < 160 || !hasElevation
            ? null
            : [
                BoxShadow(
                  color: backPanelColor.computeLuminance() > 0.335
                      ? Colors.black.withOpacity(0.1)
                      : Colors.black.withOpacity(0.2),
                  spreadRadius: elevationSpreadRadius ?? 1.0,
                  blurRadius: elevationBlurRadius ?? 3.0,
                  offset: Offset(2.0, 2.0),
                ),
                BoxShadow(
                  color: backPanelColor.computeLuminance() > 0.335
                      ? Colors.black.withOpacity(0.1)
                      : Colors.black.withOpacity(0.2),
                  spreadRadius: elevationSpreadRadius ?? 1.0,
                  blurRadius: elevationBlurRadius ?? 3.0,
                  offset: Offset(-0.2, -0.2),
                ),
              ],
      ),
      child: FittedBox(
        child: Stack(
          children: <Widget>[
            Container(
              width: width - cameraBumpPartsPadding,
              height: height - cameraBumpPartsPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(effectCornerRadius),
                gradient: cameraBumpColor.alpha == 0
                    ? null
                    : isMatte
                        //Matte Effect
                        ? LinearGradient(
                            colors: [
                              Colors.transparent,
                              backPanelColor.computeLuminance() > 0.335
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.2)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        //Glossy Effect
                        : LinearGradient(
                            colors: [
                              Colors.transparent,
                              cameraBumpColor.computeLuminance() > 0.335
                                  ? Colors.black.withOpacity(0.03)
                                  : Colors.black.withOpacity(0.07),
                            ],
                            stops: [0.6, 0.6],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
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
