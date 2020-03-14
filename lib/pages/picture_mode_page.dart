import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:mobwear/data/models/aspect_ratio_model.dart';
import 'package:mobwear/data/models/brand_model.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/aspect_ratio_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/customization_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/fab_bottom_appbar.dart';
import 'package:mobwear/widgets/app_widgets/flushbars.dart';
import 'package:mobwear/widgets/app_widgets/save_image_dialog.dart';
import 'package:mobwear/widgets/app_widgets/watermark_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PictureModePage extends StatefulWidget {
  static const String id = '/PictureModePage';

  final dynamic phone;
  final int phoneID;

  PictureModePage({this.phone, this.phoneID});

  @override
  _PictureModePageState createState() => _PictureModePageState();
}

class _PictureModePageState extends State<PictureModePage> {
  Matrix4 matrix;
  GlobalKey matrixDetectorKey = GlobalKey();
  Color initRandomColor, backgroundColor;
  MyTexture backgroundTexture;
  bool isCapturing = false;
  GlobalKey captureKey = GlobalKey();

  static Box settingsBox = SettingsDatabase.settingsBox;
  bool showMoveTip = settingsBox.get(SettingsDatabase.movePhoneTipKey) != 1;

  @override
  void initState() {
    super.initState();
    matrix = Matrix4.identity();
    initRandomColor = Colors.primaries[Random().nextInt(15)];
    WidgetsBinding.instance.addPostFrameCallback((_) => showMoveTipFlushbar());
  }

  void showMoveTipFlushbar() {
    if (showMoveTip) {
      Future.delayed(Duration(milliseconds: 1500), () {
        MyFlushbars.showTipFlushbar(
          context,
          title: 'Tip: Move, Rotate & Resize',
          message: 'You can manipulate the phone to get the perfect picture',
          onDismiss: () => settingsBox.put(SettingsDatabase.movePhoneTipKey, 1),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Color(0xFF0C0C0C)),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Consumer<CustomizationProvider>(
          builder: (context, provider, child) {
            backgroundColor = provider.currentColor ?? initRandomColor;
            backgroundTexture = MyTexture(
              asset: provider.currentTexture,
              blendColor: provider.currentBlendColor ?? Colors.deepOrange,
              blendModeIndex: provider.currentBlendModeIndex ?? 0,
            );

            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: buildAppBar(),
              body: buildPictureCanvas(provider),
              floatingActionButton: buildFAB(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: buildBottomAppBar(),
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Material(
        color: Colors.transparent,
        textStyle: TextStyle(
          fontFamily: 'Righteous',
          fontSize: 26.0,
          color: kThemeBrightness(context) == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
        child: Text('Picture Mode'),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(LineAwesomeIcons.angle_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildBottomAppBar() {
    return FABBottomAppBar(
      centerItemText: 'Save',
      foregroundColor: kBrightnessAwareColor(context,
          lightColor: Colors.black, darkColor: Colors.white),
      selectedColor: Theme.of(context).brightness == Brightness.light
          ? Colors.red[900]
          : Colors.red,
      notchedShape: CircularNotchedRectangle(),
      onItemSelected: (i) => onItemSelected(i),
      items: [
        FABBottomAppBarItem(LineAwesomeIcons.edit),
        FABBottomAppBarItem(LineAwesomeIcons.file_word_o),
        FABBottomAppBarItem(LineAwesomeIcons.arrows_alt),
        FABBottomAppBarItem(LineAwesomeIcons.refresh),
      ],
    );
  }

  FloatingActionButton buildFAB(BuildContext context) {
    return FloatingActionButton(
      elevation: 2.0,
      onPressed: () => saveImage(),
      child: isCapturing
          ? Container(
              height: 24.0,
              width: 24.0,
              padding: EdgeInsets.all(4.5),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  kBrightnessAwareColor(context,
                      lightColor: Colors.white, darkColor: Colors.black),
                ),
              ),
            )
          : Icon(LineAwesomeIcons.save),
    );
  }

  Widget buildPictureCanvas(CustomizationProvider provider) {
    DecorationImage backgroundImage = backgroundTexture.asset == null
        ? null
        : DecorationImage(
            image: AssetImage(backgroundTexture.asset),
            fit: BoxFit.cover,
            colorFilter: backgroundTexture.blendModeIndex == null
                ? null
                : ColorFilter.mode(
                    backgroundTexture.blendColor,
                    kGetTextureBlendMode(backgroundTexture.blendModeIndex),
                  ),
          );

    List<BoxShadow> boxShadow = backgroundColor.alpha > 150
        ? [
            BoxShadow(
              color: kBrightnessAwareColor(context,
                  lightColor: Colors.blueGrey.withOpacity(0.2),
                  darkColor: Colors.black26),
              blurRadius: 10.0,
              offset: Offset(5.0, 6.0),
            ),
          ]
        : null;

    Border border =
        kGetColorString(backgroundColor) == kGetColorString(Colors.black)
            ? Border.all(
                color: Colors.grey[800],
                width: 0.3,
              )
            : null;

    Widget watermark() {
      return provider.showWatermark
          ? Align(
              alignment: MyPosition
                  .myPositions[provider.watermarkPositionIndex].alignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  BrandIcon.watermarkIcons[provider.watermarkIndex].icon,
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
          : Container();
    }

    return Container(
      padding: EdgeInsets.only(bottom: 32.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: RepaintBoundary(
            key: captureKey,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: MyAspectRatio
                      .myAspectRatios[provider.aspectRatioIndex].ratio,
                  child: Container(
                    decoration: BoxDecoration(
                      border: border,
                      boxShadow: boxShadow,
                      color: backgroundImage == null
                          ? backgroundColor
                          : Colors.transparent,
                      image: backgroundImage,
                    ),
                    child: MatrixGestureDetector(
                      key: matrixDetectorKey,
                      onMatrixUpdate: (m, tm, sm, rm) {
                        setState(() {
                          matrix =
                              MatrixGestureDetector.compose(matrix, tm, sm, rm);
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          watermark(),
                          Transform(
                            transform: matrix,
                            child: Container(
                              padding: EdgeInsets.all(24.0),
                              child: Hero(
                                tag: widget.phoneID,
                                child: widget.phone,
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
        ),
      ),
    );
  }

  void onItemSelected(i) {
    int item = i;
    switch (item) {
      case 0:
        changeBackground(context);
        break;
      case 1:
        changeWatermark(context);
        break;
      case 2:
        changeAspectRatio();
        break;
      case 3:
        resetPage();
        break;
    }
  }

  Future<void> saveImage() async {
    captureImage().then(
      (imageBytes) {
        showDialog<Widget>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: SaveImageDialog(
              bytes: imageBytes,
              phone: widget.phone,
            ),
          ),
        );
      },
    );
  }

  Future<Uint8List> captureImage() async {
    Uint8List imageBytes;

    setState(() => isCapturing = true);
    try {
      RenderRepaintBoundary boundary =
          captureKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 4.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      imageBytes = byteData.buffer.asUint8List();
      // var bs64 = base64Encode(pngBytes);
    } catch (e) {
      String errorText = 'Unable to save. Please try again later';
      Toast.show(errorText, context);
      print(e);
    } finally {
      setState(() => isCapturing = false);
    }
    return imageBytes;
  }

  void changeBackground(BuildContext context) {
    Provider.of<CustomizationProvider>(context).isSharePage = true;
    Provider.of<CustomizationProvider>(context).selectedTexture = null;
    Provider.of<CustomizationProvider>(context).getCurrentSideTextureDetails();
    Provider.of<CustomizationProvider>(context).resetSelectedValues();

    int initIndex() {
      if (backgroundTexture.asset != null) return 1;
      return 0;
    }

    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: CustomizationPickerDialog(
          noTexture: false,
          noImage: true,
          initPickerModeIndex: initIndex(),
          initRandomColor: initRandomColor,
        ),
      ),
    );
  }

  void changeAspectRatio() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AspectRatioPickerDialog();
      },
    );
  }

  void changeWatermark(BuildContext context) {
    Provider.of<CustomizationProvider>(context).resetSelectedValues();

    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: WatermarkPickerDialog(
          backgroundColor: backgroundColor ?? initRandomColor,
          backgroundTexture: backgroundTexture,
        ),
      ),
    );
  }

  void resetPage() {
    Provider.of<CustomizationProvider>(context).resetCurrentValues();
    setState(() {
      matrix = Matrix4.identity();
      initRandomColor = Colors.primaries[Random().nextInt(15)];
    });
  }

  Future<bool> onWillPop() {
    return Future.value(true);
  }
}
