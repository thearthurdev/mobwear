import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/texture_model.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/aspect_ratio_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/customization_picker_dialog.dart';
import 'package:mobwear/widgets/app_widgets/fab_bottom_appbar.dart';
import 'package:mobwear/widgets/app_widgets/picture_canvas.dart';
import 'package:mobwear/widgets/app_widgets/watermark_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SharePhonePage extends StatefulWidget {
  static String id = '/SharePhonePage';

  final phone;
  final phoneID;

  SharePhonePage({this.phone, this.phoneID});

  @override
  _SharePhonePageState createState() => _SharePhonePageState();
}

class _SharePhonePageState extends State<SharePhonePage> {
  Color initRandomColor, backgroundColor;
  MyTexture backgroundTexture;
  bool isCapturing = false;
  GlobalKey captureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initRandomColor = Colors.primaries[Random().nextInt(15)];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: kThemeBrightness(context) == Brightness.light
            ? Colors.white
            : Color(0xFF0C0C0C),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
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
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(LineAwesomeIcons.angle_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(bottom: 32.0),
            child: Center(
              child: PictureCanvas(
                captureKey: captureKey,
                phone: widget.phone,
                phoneID: widget.phoneID,
                initRandomColor: initRandomColor,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 2.0,
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
                : Icon(
                    LineAwesomeIcons.share_alt,
                  ),
            onPressed: captureImage,
          ),
          bottomNavigationBar: Consumer<CustomizationProvider>(
            builder: (context, provider, child) {
              backgroundColor = provider.currentColor ?? initRandomColor;
              backgroundTexture = MyTexture(
                asset: provider.currentTexture,
                blendColor: provider.currentBlendColor ?? Colors.deepOrange,
                blendModeIndex: provider.currentBlendModeIndex ?? 0,
              );

              return FABBottomAppBar(
                centerItemText: 'Share',
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
            },
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

  void captureImage() async {
    try {
      setState(() => isCapturing = true);
      RenderRepaintBoundary boundary =
          captureKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 4.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      // var bs64 = base64Encode(pngBytes);
      setState(() => isCapturing = false);
      share(pngBytes);
    } catch (e) {
      String errorText = 'Unable to share. Please try again later';
      setState(() => isCapturing = false);
      Toast.show(errorText, context);
      print(e);
    }
  }

  void share(Uint8List bytes) async {
    await Share.file(
      'Share your ${widget.phone.getPhoneName}',
      '${widget.phone.getPhoneName}.png',
      bytes,
      'image/png',
      text:
          'Check out this ${widget.phone.getPhoneName} I customized with MobWear!',
    );
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SharePhonePage(
          phone: widget.phone,
          phoneID: widget.phoneID,
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    return Future.value(true);
  }
}
