import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/adaptiveDialog.dart';
import 'package:provider/provider.dart';

class GalleryItemDeleteDialog extends StatelessWidget {
  final GalleryItem item;

  const GalleryItemDeleteDialog(this.item);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AdaptiveDialog(
        title: 'Delete',
        selectText: 'Delete',
        onSelectPressed: () {
          Navigator.pop(context);
          Provider.of<GalleryProvider>(context, listen: false)
              .deleteItem(item.imageFileName);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Text(
            'Are you sure you want to delete'
            '\n${item.imageFileName}?',
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
