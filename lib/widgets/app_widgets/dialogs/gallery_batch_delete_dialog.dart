import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/dialogs/adaptive_dialog.dart';
import 'package:provider/provider.dart';

class GalleryBatchDeleteDialog extends StatelessWidget {
  final List<String> selectedItemKeys;

  const GalleryBatchDeleteDialog(this.selectedItemKeys);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(
          context,
          lightColor: Color(0xFF757575),
          darkColor: Colors.black,
        ),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: AdaptiveDialog(
        title: 'Delete',
        selectText: 'Delete',
        onSelectPressed: () {
          Provider.of<GalleryProvider>(context, listen: false)
              .deleteBatchItems(selectedItemKeys)
              .whenComplete(() {
            Navigator.pop(context);
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Text(
            'Are you sure you want to delete ${selectedItemKeys.length} ${selectedItemKeys.length == 1 ? 'image' : 'images'}?',
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
