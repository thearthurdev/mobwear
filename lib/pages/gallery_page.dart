import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/data/models/gallery_item_model.dart';
import 'package:mobwear/pages/gallery_view_page.dart';
import 'package:mobwear/providers/gallery_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';
import 'package:mobwear/widgets/app_widgets/gallery_batch_delete_dialog.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatefulWidget {
  static const String id = '/GalleryPage';

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryItem> items;
  List<String> selectedItemKeys = [];
  bool isWideScreen;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = Provider.of<GalleryProvider>(context).galleryItems;
  }

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context);

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
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(selectedItemKeys.isNotEmpty
                    ? '${selectedItemKeys.length}'
                        ' ${selectedItemKeys.length == 1 ? 'image' : 'images'} selected'
                    : 'Gallery'),
                centerTitle: true,
                pinned: true,
                leading: selectedItemKeys.isNotEmpty
                    ? IconButton(
                        icon: Icon(LineAwesomeIcons.close),
                        onPressed: () =>
                            setState(() => selectedItemKeys.clear()),
                      )
                    : IconButton(
                        icon: Icon(LineAwesomeIcons.angle_left),
                        onPressed: () => Navigator.pop(context),
                      ),
                actions: <Widget>[
                  selectedItemKeys.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            LineAwesomeIcons.check_square,
                          ),
                          onPressed: () {
                            selectedItemKeys.clear();
                            setState(() {
                              for (int i = 0; i != items.length; i++) {
                                selectedItemKeys.add(items[i].imageFileName);
                              }
                            });
                          },
                        )
                      : Container()
                ],
              ),
              buildGalleryBody(context),
            ],
          ),
          floatingActionButton: selectedItemKeys.isNotEmpty ? buildFAB() : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  Widget buildFAB() {
    void onFABPressed() {
      showDialog<Widget>(
        context: context,
        builder: (BuildContext context) =>
            GalleryBatchDeleteDialog(selectedItemKeys),
      ).whenComplete(
        () => setState(() => selectedItemKeys.clear()),
      );
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOutSine,
      height: selectedItemKeys.isNotEmpty ? 56.0 : 0.0,
      child: isWideScreen && kDeviceHeight(context) > 400.0
          ? FloatingActionButton.extended(
              label: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: selectedItemKeys.isNotEmpty ? 1.0 : 0.0,
                child: Text('Delete', style: kTitleTextStyle),
              ),
              icon: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: selectedItemKeys.isNotEmpty ? 1.0 : 0.0,
                child: Icon(LineAwesomeIcons.trash),
              ),
              onPressed: onFABPressed,
            )
          : FloatingActionButton(
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 250),
                  opacity: selectedItemKeys.isNotEmpty ? 1.0 : 0.0,
                  child: Icon(LineAwesomeIcons.trash)),
              onPressed: onFABPressed,
            ),
    );
  }

  Widget buildGalleryBody(BuildContext context) {
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
        crossAxisCount: isWideScreen && kDeviceIsLandscape(context) ? 8 : 4,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        itemCount: items.length,
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            child: Hero(
              tag: items[i].imageDateTime,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(0.1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kBrightnessAwareColor(context,
                            lightColor: Colors.grey.withOpacity(0.06),
                            darkColor: Colors.grey[900]),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.memory(items[i].imageBytes),
                    ),
                  ),
                  selectedItemKeys.contains(items[i].imageFileName)
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 24.0,
                            height: 24.0,
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.black26,
                            ),
                            child: Icon(
                              LineAwesomeIcons.check_circle,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            onLongPress: () => selectItem(i),
            onTap: () {
              if (selectedItemKeys.isNotEmpty) {
                selectItem(i);
              } else {
                Provider.of<GalleryProvider>(context).setCurrentIndex(i);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // fullscreenDialog: true,
                    builder: (context) => GalleryViewPage(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  void selectItem(int i) {
    if (selectedItemKeys.contains(items[i].imageFileName)) {
      setState(() {
        selectedItemKeys.remove(items[i].imageFileName);
      });
    } else {
      setState(() {
        selectedItemKeys.add(items[i].imageFileName);
      });
    }
  }

  Future<bool> onWillPop() {
    if (selectedItemKeys.isNotEmpty) {
      setState(() => selectedItemKeys.clear());
      return Future.value(false);
    }
    return Future.value(true);
  }
}
