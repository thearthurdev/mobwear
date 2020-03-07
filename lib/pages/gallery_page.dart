import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatelessWidget {
  static const String id = '/GalleryPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Gallery'),
            centerTitle: true,
            pinned: true,
            leading: IconButton(
              icon: Icon(LineAwesomeIcons.angle_left),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          buildGalleryBody(context),
        ],
      ),
    );
  }

  Widget buildGalleryBody(BuildContext context) {
    GalleryProvider provider = Provider.of<GalleryProvider>(context);

    if (provider.galleryItems.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAccentButton(icon: LineAwesomeIcons.image),
            SizedBox(height: 8.0),
            Text('No images found', style: kTitleTextStyle),
            SizedBox(height: 4.0),
            Text('Let\'s get customizing!', style: kSubtitleTextStyle),
          ],
        ),
      );
    }

    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
