import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:mobware/custom_icons/custom_icons.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/widgets/app_widgets/customization_picker_tile.dart';
import 'package:toast/toast.dart';

class SharePhonePage extends StatefulWidget {
  static String id = '/SharePhonePage';

  final phone;

  SharePhonePage({this.phone});

  @override
  _SharePhonePageState createState() => _SharePhonePageState();
}

class _SharePhonePageState extends State<SharePhonePage> {
  double backgroundWidth = 426.0;
  double backgroundheight = 426.0;
  bool isCapturing = false;
  Color backgroundColor;
  Matrix4 matrix;
  GlobalKey captureKey = GlobalKey();

  @override
  void initState() {
    matrix = Matrix4.identity();
    int randomInt = Random().nextInt(15);
    backgroundColor = Colors.primaries[randomInt];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture Mode'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                constraints: BoxConstraints(maxHeight: 500.0),
                child: RepaintBoundary(
                  key: captureKey,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: backgroundWidth,
                    height: backgroundheight,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(5.0, 6.0),
                        ),
                      ],
                    ),
                    child: MatrixGestureDetector(
                      clipChild: true,
                      onMatrixUpdate: (m, tm, sm, rm) {
                        setState(() {
                          matrix = m;
                        });
                      },
                      child: Stack(
                        children: <Widget>[
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
                                      color:
                                          backgroundColor.computeLuminance() <
                                                  0.335
                                              ? Colors.black26
                                              : Colors.black12,
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Hero(
                                  tag: widget.phone,
                                  child: widget.phone,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                CustomIcons.mobware,
                                size: 32.0,
                                color:
                                    backgroundColor.computeLuminance() < 0.335
                                        ? Colors.white38
                                        : Colors.black38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Background Color',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
              subtitle: Text(
                'Select a background color',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: kBrightnessAwareColor(context,
                      lightColor: Colors.black54, darkColor: Colors.white54),
                ),
              ),
              trailing: ColorIndicator(color: backgroundColor),
              onTap: () => changeBackgroundColor(context, backgroundColor),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 60.0,
              child: ListTile(
                // isThreeLine: true,
                title: Text(
                  'Aspect Ratio',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                subtitle: Text(
                  'Pick an aspect ratio for the image',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: kBrightnessAwareColor(context,
                        lightColor: Colors.black54, darkColor: Colors.white54),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    aspectRatioButton(
                        aspectRatio: 1.0 / 1.0, width: 426.0, height: 426.0),
                    aspectRatioButton(
                        aspectRatio: 9.0 / 16.0, width: 240.0, height: 426.0),
                    aspectRatioButton(
                        aspectRatio: 16.0 / 9.0, width: 426.0, height: 240.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kThemeBrightness(context) == Brightness.light
            ? Colors.white
            : Colors.grey[900],
        label: Text(
          'Share',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
            color: kThemeBrightness(context) == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        icon: isCapturing
            ? Container(
                height: 24.0,
                width: 24.0,
                padding: EdgeInsets.all(4.5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              )
            : Icon(
                LineAwesomeIcons.share_alt,
                color: kThemeBrightness(context) == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
        onPressed: captureImage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget aspectRatioButton({double aspectRatio, width, height}) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: kThemeBrightness(context) == Brightness.light
                    ? Colors.grey[300]
                    : Colors.grey[700],
                width: 4.0,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          backgroundWidth = width;
          backgroundheight = height;
        });
      },
    );
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
      setState(() => isCapturing = false);
      Toast.show('Unable to share. Please try again later', context);
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
          'Check out this ${widget.phone.getPhoneName} I customized with MobWare!',
    );
  }

  void changeBackgroundColor(BuildContext context, Color currentColor) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Pick a color'),
        children: <Widget>[
          MaterialColorPicker(
            shrinkWrap: true,
            onColorChange: (Color color) {
              backgroundColor = color;
            },
            selectedColor: currentColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text('Select'),
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
