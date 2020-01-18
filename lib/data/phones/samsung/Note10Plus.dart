import 'package:flutter/material.dart';
import 'package:mobware/custom_icons/brand_icons.dart';
import 'package:mobware/providers/phones_customization_provider.dart';
import 'package:mobware/widgets/phone_widgets/back_panel.dart';
import 'package:mobware/widgets/phone_widgets/camera.dart';
import 'package:mobware/widgets/phone_widgets/camera_bump.dart';
import 'package:mobware/widgets/phone_widgets/flash.dart';
import 'package:mobware/widgets/phone_widgets/microphone.dart';
import 'package:mobware/widgets/phone_widgets/screen.dart';
import 'package:mobware/widgets/phone_widgets/texture_decoration.dart';
import 'package:provider/provider.dart';

class Note10Plus extends StatelessWidget {
  final int phoneIndex = 2;
  final int phoneBrandIndex = 2;
  static const String phoneBrand = 'Samsung';
  static const String phoneModel = 'Galaxy';
  static const String phoneName = 'Galaxy Note 10 Plus';

  final Screen front = Screen(
    phoneName: phoneName,
    phoneModel: phoneModel,
    phoneBrand: phoneBrand,
    screenWidth: 240.0,
    screenHeight: 510.0,
    bezelHorizontal: 5.0,
    bezelVertical: 15.0,
    screenAlignment: Alignment(0.0, -0.5),
    innerCornerRadius: 6.0,
    cornerRadius: 6.0,
    screenItems: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Camera(
            diameter: 15.0,
            lenseDiameter: 5.0,
            trimWidth: 0.0,
          ),
        ),
      ),
    ],
  );

  get getPhoneFront => front;
  get getPhoneName => phoneName;
  get getPhoneBrand => phoneBrand;

  @override
  Widget build(BuildContext context) {
    var colors = Provider.of<PhoneCustomizationProvider>(context)
        .samsungs[phoneIndex]
        .colors;
    var textures = Provider.of<PhoneCustomizationProvider>(context)
        .samsungs[phoneIndex]
        .textures;

    Color backPanelColor = colors['Back Panel'];
    Color cameraBumpColor = colors['Camera Bump'];
    Color logoColor = colors['Samsung Logo'];
    Color bezelColor = colors['Bezels'];

    String cameraBumpTexture = textures['Camera Bump'].asset;
    Color cameraBumpTextureBlendColor = textures['Camera Bump'].blendColor;
    BlendMode cameraBumpTextureBlendMode = textures['Camera Bump'].blendMode;
    String backPanelTexture = textures['Back Panel'].asset;
    Color backPanelTextureBlendColor = textures['Back Panel'].blendColor;
    BlendMode backPanelTextureBlendMode = textures['Back Panel'].blendMode;

    Camera camera = Camera(
      diameter: 20.0,
      trimWidth: 3.0,
      lenseDiameter: 8.0,
      trimColor: Colors.grey[900],
    );

    CameraBump cameraBump = CameraBump(
      width: 35.0,
      height: 105.0,
      cameraBumpColor: cameraBumpColor,
      backPanelColor: backPanelColor,
      texture: cameraBumpTexture,
      textureBlendColor: cameraBumpTextureBlendColor,
      textureBlendMode: cameraBumpTextureBlendMode,
      cameraBumpPartsPadding: 2.0,
      borderWidth: 2.0,
      borderColor: Colors.grey[500],
      cameraBumpParts: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              camera,
              camera,
              camera,
            ],
          ),
        ),
      ],
    );

    return FittedBox(
      child: Stack(
        children: <Widget>[
          BackPanel(
            height: 510,
            cornerRadius: 6.0,
            backPanelColor: Colors.transparent,
            bezelColor: Colors.transparent,
            child: Container(),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 240.0,
              height: 510.0,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(6.0),
                color: backPanelColor,
                border: Border(
                  top: BorderSide(
                    color: bezelColor,
                    width: 3.0,
                  ),
                  bottom: BorderSide(
                    color: bezelColor,
                    width: 3.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5, 5),
                    spreadRadius: 2.0,
                    blurRadius: 10.0,
                  ),
                ],
                image: textureDecoration(
                  texture: backPanelTexture,
                  textureBlendColor: backPanelTextureBlendColor,
                  textureBlendMode: backPanelTextureBlendMode,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(6.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          backPanelColor.computeLuminance() > 0.335
                              ? Colors.black.withOpacity(0.019)
                              : Colors.black.withOpacity(0.025),
                        ],
                        stops: [0.2, 0.2],
                        begin: FractionalOffset(0.7, 0.3),
                        end: FractionalOffset(0.0, 0.5),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment(-0.150, -0.3),
                      child: Icon(
                        BrandIcons.samsung3,
                        color: logoColor,
                        size: 54.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18.0,
                    left: 20.0,
                    child: cameraBump,
                  ),
                  Positioned(
                    left: 70.0,
                    top: 33.0,
                    child: Column(
                      children: <Widget>[
                        Flash(diameter: 10.0),
                        SizedBox(height: 8.0),
                        Microphone(diameter: 10.0),
                        SizedBox(height: 8.0),
                        Microphone(diameter: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
