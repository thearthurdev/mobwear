import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
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
                      'Delete',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Are you sure you want to delete ${selectedItemKeys.length} ${selectedItemKeys.length == 1 ? 'image' : 'images'}?',
                style: kTitleTextStyle,
                textAlign: TextAlign.center,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                buttonTextTheme: ButtonTextTheme.normal,
                children: <Widget>[
                  FlatButton(
                    child: Text('Cancel', style: kTitleTextStyle),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text('Delete', style: kTitleTextStyle),
                    onPressed: () {
                      Provider.of<GalleryProvider>(context)
                          .deleteBatchItems(selectedItemKeys)
                          .whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
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
