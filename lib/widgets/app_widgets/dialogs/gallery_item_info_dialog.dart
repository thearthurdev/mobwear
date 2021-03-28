import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/adaptive_dialog.dart';

class GalleryItemInfoDialog extends StatelessWidget {
  final GalleryItem item;

  const GalleryItemInfoDialog(this.item);

  @override
  Widget build(BuildContext context) {
    Map<IconData, String> infoSections = {
      LineAwesomeIcons.file_photo_o: item.imageFileName,
      LineAwesomeIcons.mobile_phone: '${item.phoneBrand} ${item.phoneName}',
      // kGetBrandIconFromName(item.phoneBrand): item.phoneBrand,
      LineAwesomeIcons.calendar_o: item.imageDateTime.split(".")[0],
      item.isFavorite ? LineAwesomeIcons.heart : LineAwesomeIcons.heart_o:
          item.isFavorite ? 'Favorited' : 'Not Favorited',
    };

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AdaptiveDialog(
        title: 'Info',
        hasSelectButton: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: infoSections.length,
              itemBuilder: (context, i) {
                return infoListTile(
                  context,
                  icon: infoSections.keys.elementAt(i),
                  title: infoSections.values.elementAt(i),
                );
              },
            ),
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
