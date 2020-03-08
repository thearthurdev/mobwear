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
    Map<IconData, String> infoSections = {
      LineAwesomeIcons.file_photo_o: item.imageFileName,
      LineAwesomeIcons.mobile_phone: item.phoneName,
      kGetBrandIconFromName(item.phoneBrand): item.phoneBrand,
      LineAwesomeIcons.calendar_o: item.imageDateTime.split(".")[0],
      item.isFavorite ? LineAwesomeIcons.heart : LineAwesomeIcons.heart_o:
          item.isFavorite ? 'Favorited' : 'Not Favorited',
    };

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
                ] +
                List.generate(infoSections.length, (i) {
                  return infoListTile(
                    context,
                    icon: infoSections.keys.elementAt(i),
                    title: infoSections.values.elementAt(i),
                  );
                }) +
                [
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

  ListTile infoListTile(BuildContext context, {IconData icon, String title}) {
    return ListTile(
      leading: Icon(
        icon,
        color: kBrightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.white),
      ),
      title: Text(title, style: kTitleTextStyle),
    );
  }
}
