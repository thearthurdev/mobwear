import 'dart:typed_data';
import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/database/gallery_database.dart';
import 'package:mobwear/utils/constants.dart';
// import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:toast/toast.dart';

class SaveImageDialog extends StatefulWidget {
  final Uint8List bytes;
  final dynamic phone;

  const SaveImageDialog({this.bytes, this.phone});

  @override
  _SaveImageDialogState createState() => _SaveImageDialogState();
}

class _SaveImageDialogState extends State<SaveImageDialog> {
  // final imageSaver = ImageSaver();
  String phoneName;
  String phoneBrand;

  @override
  void initState() {
    super.initState();
    phoneName = widget.phone.getPhoneName;
    phoneBrand = widget.phone.getPhoneBrand;
  }

  Future<dynamic> saveImage() async {
    dynamic res;
    try {
      // res = await imageSaver.saveNamedImages(
      //   namedImageBytes: {'${widget.phoneName}_$dateTime': widget.bytes},
      //   directoryName: 'MobWear',
      // );
      Box galleryBox = GalleryDatabase.galleryBox;

      galleryBox.add(
        GalleryDatabaseItem(
          imageString: String.fromCharCodes(widget.bytes),
          imageDateTime: DateTime.now().toString(),
          imageFileName: '${kGetCombinedName(phoneName)}_${kGetDateTime()}.png',
          phoneName: phoneName,
          phoneBrand: phoneBrand,
          isFavorite: false,
        ),
      );
    } catch (e) {
      print(e);
    }
    return res;
  }

  Future<void> shareImage() async {
    try {
      await Share.file(
        'Share your $phoneName',
        '${kGetCombinedName(phoneName)}_${kGetDateTime()}.png',
        widget.bytes,
        'image/png',
        text: 'Check out this $phoneName I customized with MobWear!',
      );
    } catch (e) {
      String errorText = 'Unable to share. Please try again later';
      Toast.show(errorText, context);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Color(0xFF757575), darkColor: Color(0xFF060606)),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: SingleChildScrollView(
        child: Container(
          // height: kScreenAwareSize(220.0, context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 8.0, 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Save',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: saveImage(),
                builder: (context, snapshot) {
                  if (snapshot.data == null &&
                      snapshot.connectionState != ConnectionState.done) {
                    return Container(
                      height: kScreenAwareSize(180.0, context),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.data == false) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'uh-oh!',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'Righteous',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            'An error occured while saving',
                            style: kSubtitleTextStyle,
                          ),
                          SizedBox(height: 24.0),
                          dialogButton(
                            context: context,
                            label: 'Try Again',
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: 16.0),
                          dialogButton(
                            context: context,
                            label: 'Share Picture Directly',
                            onTap: () => shareImage(),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'yay!',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'Righteous',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          '${kGetCombinedName(phoneName)}_${kGetDateTime()}.png'
                          '\nsaved to gallery',
                          style: kSubtitleTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.0),
                        dialogButton(
                          context: context,
                          label: 'Share',
                          onTap: () => shareImage(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogButton({BuildContext context, String label, Function onTap}) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.white),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: kTitleTextStyle.copyWith(
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.white, darkColor: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
