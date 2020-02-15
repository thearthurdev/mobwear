import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:mobwear/data/models/aspect_ratio_model.dart';
import 'package:mobwear/data/models/brand_icon_model.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class PictureCanvas extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> captureKey;
  final dynamic phone;
  final int phoneID;
  final Color initRandomColor;

  const PictureCanvas({
    @required this.captureKey,
    @required this.phone,
    @required this.phoneID,
    @required this.initRandomColor,
  });

  @override
  _PictureCanvasState createState() => _PictureCanvasState();
}

class _PictureCanvasState extends State<PictureCanvas> {
  Color initRandomColor, backgroundColor;
  MyTexture backgroundTexture;
  Matrix4 matrix;
  GlobalKey matrixDetectorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    matrix = Matrix4.identity();
    initRandomColor = widget.initRandomColor;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationProvider>(
      builder: (context, provider, child) {
        backgroundColor = provider.currentColor ?? initRandomColor;
        backgroundTexture = MyTexture(
          asset: provider.currentTexture,
          blendColor: provider.currentBlendColor ?? Colors.deepOrange,
          blendModeIndex: provider.currentBlendModeIndex ?? 0,
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: RepaintBoundary(
            key: widget.captureKey,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: MyAspectRatio.myAspectRatios(
                          context)[provider.aspectRatioIndex]
                      .ratio,
                  child: Container(
                    decoration: BoxDecoration(
                      border: kGetColorString(backgroundColor) ==
                              kGetColorString(Colors.black)
                          ? Border.all(
                              color: Colors.grey[800],
                              width: 0.3,
                            )
                          : null,
                      boxShadow: backgroundColor.alpha > 150
                          ? [
                              BoxShadow(
                                color: kBrightnessAwareColor(context,
                                    lightColor:
                                        Colors.blueGrey.withOpacity(0.2),
                                    darkColor: Colors.black26),
                                blurRadius: 10.0,
                                offset: Offset(5.0, 6.0),
                              ),
                            ]
                          : null,
                      color: backgroundTexture.asset == null
                          ? backgroundColor
                          : Colors.transparent,
                      image: backgroundTexture.asset == null
                          ? null
                          : DecorationImage(
                              image: AssetImage(backgroundTexture.asset),
                              fit: BoxFit.cover,
                              colorFilter:
                                  backgroundTexture.blendModeIndex == null
                                      ? null
                                      : ColorFilter.mode(
                                          backgroundTexture.blendColor,
                                          kGetTextureBlendMode(
                                              backgroundTexture.blendModeIndex),
                                        ),
                            ),
                    ),
                    child: MatrixGestureDetector(
                      key: matrixDetectorKey,
                      onMatrixUpdate: (m, tm, sm, rm) {
                        setState(() {
                          matrix = m;
                        });
                      },
                      child: Stack(
                        children: <Widget>[
                          provider.showWatermark
                              ? Align(
                                  alignment: Position
                                      .myPositions[
                                          provider.watermarkPositionIndex]
                                      .alignment,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      BrandIcon
                                          .watermarkIcons[
                                              provider.watermarkIndex]
                                          .icon,
                                      size: kScreenAwareSize(28.0, context),
                                      color: provider.watermarkColor ??
                                          kEstimateColorFromColorBrightness(
                                            backgroundColor,
                                            lightColor: Colors.white38,
                                            darkColor: Colors.black38,
                                          ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.center,
                            child: Transform(
                              transform: matrix,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 360,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kEstimateColorFromColorBrightness(
                                        backgroundColor,
                                        lightColor: Colors.black26,
                                        darkColor: Colors.black12,
                                      ),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      matrix = Matrix4.identity();
                                    });
                                  },
                                  child: Hero(
                                    tag: widget.phoneID,
                                    child: widget.phone,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
