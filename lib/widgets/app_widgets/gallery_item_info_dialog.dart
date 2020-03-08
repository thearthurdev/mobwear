import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/utils/constants.dart';

class GalleryItemInfoDialog extends StatelessWidget {
  final GalleryItem item;

  const GalleryItemInfoDialog(this.item);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Info',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(LineAwesomeIcons.file_photo_o),
                title: Text(item.imageFileName),
              ),
              ListTile(
                leading: Icon(LineAwesomeIcons.mobile_phone),
                title: Text(item.phoneName),
              ),
              ListTile(
                leading: Icon(kGetBrandIconFromName(item.phoneBrand)),
                title: Text(item.phoneBrand),
              ),
              ListTile(
                leading: Icon(LineAwesomeIcons.calendar_o),
                title: Text(item.imageDateTime.split(".")[0]),
              ),
              ListTile(
                leading: Icon(item.isFavorite
                    ? LineAwesomeIcons.heart
                    : LineAwesomeIcons.heart_o),
                title: Text(
                  item.isFavorite ? 'Favorited' : 'Not Favorited',
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                buttonTextTheme: ButtonTextTheme.normal,
                children: <Widget>[
                  FlatButton(
                    child: Text('Cancel', style: kTitleTextStyle),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
