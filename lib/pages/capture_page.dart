import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:mobwear/custom_icons/custom_icons.dart';
import 'package:mobwear/data/models/aspect_ratio_model.dart';
import 'package:mobwear/data/models/brand_model.dart';
import 'package:mobwear/data/models/position_model.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/aspect_ratio_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/customization_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/elevated_card.dart';
import 'package:mobwear/widgets/app_widgets/fab_bottom_appbar.dart';
import 'package:mobwear/widgets/app_widgets/flushbars.dart';
import 'package:mobwear/widgets/app_widgets/save_image_dialog.dart';
import 'package:mobwear/widgets/app_widgets/show_up_widget.dart';
import 'package:mobwear/widgets/app_widgets/watermark_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CapturePage extends StatefulWidget {
  static const String id = '/CapturePage';

  final dynamic phone;
  final int phoneID;

  CapturePage({this.phone, this.phoneID});

  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  Matrix4 matrix;
  GlobalKey matrixDetectorKey = GlobalKey();
  GlobalKey captureKey = GlobalKey();
  Box settingsBox = SettingsDatabase.settingsBox;
  Color initRandomColor, backgroundColor;
  MyTexture backgroundTexture;
  bool isCapturing = false;
  bool isWideScreen, isLargeScreen, showMoveTip;

  @override
  void initState() {
    super.initState();
    matrix = Matrix4.identity();
    initRandomColor = Colors.primaries[Random().nextInt(15)];
    showMoveTip = settingsBox.get(SettingsDatabase.movePhoneTipKey) != 1;
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
    isWideScreen = kIsWideScreen(context) &&
            kDeviceWidth(context) > kDeviceHeight(context) ||
        kDeviceIsLandscape(context);
    isLargeScreen = kDeviceHeight(context) >= 500.0 || !isWideScreen;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Colors.white,
            darkColor: isWideScreen ? Colors.black : Color(0xFF0C0C0C)),
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

            return buildBody();
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    if (isWideScreen) {
      return buildWideScreenLayout();
    }
    return buildNormalLayout();
  }

  Widget buildWideScreenLayout() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      floatingActionButton: isLargeScreen ? buildFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(
                    kScreenAwareSize(16.0, context),
                  ),
                  child: buildPictureCanvas(),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                    right: kScreenAwareSize(24.0, context),
                  ),
                  child: buildActionTileList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNormalLayout() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: buildPictureCanvas(),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  Widget saveIcon() {
    if (isCapturing) {
      return Container(
        height: 24.0,
        width: 24.0,
        padding: EdgeInsets.all(4.5),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            kBrightnessAwareColor(
              context,
              lightColor:
                  !isLargeScreen && isWideScreen ? Colors.black : Colors.white,
              darkColor:
                  !isLargeScreen && isWideScreen ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }
    return Icon(LineAwesomeIcons.save);
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
        child: Text('Capture'),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(LineAwesomeIcons.angle_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: isLargeScreen
          ? null
          : <Widget>[
              IconButton(
                icon: saveIcon(),
                onPressed: () => saveImage(),
              ),
            ],
    );
  }

  Widget buildBottomAppBar() {
    return FABBottomAppBar(
      centerItemText: 'Save',
      foregroundColor: kBrightnessAwareColor(context,
          lightColor: Colors.black, darkColor: Colors.white),
      notchedShape: CircularNotchedRectangle(),
      onItemSelected: (i) => onItemSelected(i),
      items: [
        FABBottomAppBarItem(LineAwesomeIcons.photo),
        FABBottomAppBarItem(LineAwesomeIcons.tint),
        FABBottomAppBarItem(CustomIcons.aspect_ratio2, size: 20.0),
        FABBottomAppBarItem(LineAwesomeIcons.refresh),
      ],
    );
  }

  Widget buildFAB() {
    if (isWideScreen) {
      return FloatingActionButton.extended(
        label: Text('Save', style: kTitleTextStyle),
        icon: saveIcon(),
        onPressed: () => saveImage(),
      );
    }
    return FloatingActionButton(
      elevation: 2.0,
      onPressed: () => saveImage(),
      child: saveIcon(),
    );
  }

  Widget buildActionTileList() {
    Map<String, IconData> actionIcons = {
      'Background': LineAwesomeIcons.photo,
      'Watermark': LineAwesomeIcons.tint,
      'Aspect Ratio': CustomIcons.aspect_ratio2,
      'Reset': LineAwesomeIcons.refresh,
    };

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          actionIcons.length,
          (i) {
            return ShowUp(
              delay: 100 * i,
              child: ElevatedCard(
                margin: EdgeInsets.fromLTRB(
                  16.0,
                  8.0,
                  16.0,
                  i == actionIcons.length - 1 ? 16.0 : 8.0,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => onItemSelected(i),
                    child: ListTile(
                      title: Text(actionIcons.keys.elementAt(i),
                          style: kTitleTextStyle),
                      trailing: Icon(
                        actionIcons.values.elementAt(i),
                        color: kBrightnessAwareColor(context,
                            lightColor: Colors.black, darkColor: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildPictureCanvas() {
    CustomizationProvider provider =
        Provider.of<CustomizationProvider>(context);

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

    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          16.0,
          16.0,
          16.0,
          isWideScreen ? 16.0 : 48.0,
        ),
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
                          child: Padding(
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
    );
  }

//Business Logic
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
    if (!isCapturing) {
      captureImage().then(
        (imageBytes) {
          showDialog<Widget>(
            context: context,
            builder: (BuildContext context) => SaveImageDialog(
              bytes: imageBytes,
              phone: widget.phone,
            ),
          ).whenComplete(() {
            Provider.of<CustomizationProvider>(context, listen: false)
                .changeSavingState(false);
          });
        },
      );
    }
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
      Provider.of<CustomizationProvider>(context, listen: false)
          .changeSavingState(false);
      String errorText = 'Unable to save. Please try again later';
      Toast.show(errorText, context);
      print(e);
    } finally {
      setState(() => isCapturing = false);
    }
    return imageBytes;
  }

  void changeBackground(BuildContext context) {
    Provider.of<CustomizationProvider>(context, listen: false).selectedTexture =
        null;
    Provider.of<CustomizationProvider>(context, listen: false)
        .getCurrentSideTextureDetails();
    Provider.of<CustomizationProvider>(context, listen: false)
        .resetSelectedValues();

    int initIndex() {
      if (backgroundTexture.asset != null) return 1;
      return 0;
    }

    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => CustomizationPickerDialog(
        noTexture: false,
        noImage: true,
        initPickerModeIndex: initIndex(),
        initRandomColor: initRandomColor,
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
    Provider.of<CustomizationProvider>(context, listen: false)
        .resetSelectedValues();

    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => WatermarkPickerDialog(
        backgroundColor: backgroundColor ?? initRandomColor,
        backgroundTexture: backgroundTexture,
      ),
    );
  }

  void resetPage() {
    Provider.of<CustomizationProvider>(context, listen: false)
        .resetCurrentValues();
    setState(() {
      matrix = Matrix4.identity();
      initRandomColor = Colors.primaries[Random().nextInt(15)];
    });
  }

  Future<bool> onWillPop() {
    return Future.value(true);
  }
}
