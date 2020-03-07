import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/pages/gallery_view_page.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatefulWidget {
  static const String id = '/GalleryPage';

  // final List<GalleryItem> data;

  // const GalleryPage({this.data});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryItem> items;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = Provider.of<GalleryProvider>(context).galleryItems;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
        systemNavigationBarIconBrightness:
            kThemeBrightness(context) == Brightness.light
                ? Brightness.dark
                : Brightness.light,
      ),
      child: Scaffold(
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
      ),
    );
  }

  Widget buildGalleryBody(BuildContext context) {
    // GalleryProvider provider = Provider.of<GalleryProvider>(context);

    if (items.isEmpty) {
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

    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 4,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        itemCount: items.length,
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
        itemBuilder: (BuildContext context, int i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: GestureDetector(
              child: Hero(
                tag: items[i].imageDateTime,
                child: Image.memory(items[i].imageBytes),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // fullscreenDialog: true,
                    builder: (context) => GalleryViewPage(currentIndex: i),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
