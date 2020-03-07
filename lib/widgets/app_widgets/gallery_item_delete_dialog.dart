import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:provider/provider.dart';

class GalleryItemDeleteDialog extends StatelessWidget {
  final GalleryItem item;
  final int index;

  const GalleryItemDeleteDialog(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    String phoneName = item.phoneName;
    String imageDateTime = item.imageDateTime;

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
                      'Delete',
                      style: kTitleTextStyle.copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Are you sure you want to delete'
                '\n${kGetCombinedName(phoneName)}_${kGetDateTime(dateTime: imageDateTime)}.png?',
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
                      Provider.of<GalleryProvider>(context).deleteItem(index);
                      Navigator.pop(context);
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
