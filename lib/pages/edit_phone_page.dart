import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/database/phone_database.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/picture_mode_page.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:mobwear/utils/my_phone_header_delegate.dart';
import 'package:mobwear/widgets/app_widgets/customization_picker_tile.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class EditPhonePage extends StatefulWidget {
  static const String id = '/EditPhonePage';

  final dynamic phone;
  final int phoneID;

  EditPhonePage({
    this.phone,
    this.phoneID,
  });

  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();
  ScrollController scrollController;
  bool showFAB = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    // double maxScrollExtent = scrollController.position.maxScrollExtent;

    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (showFAB == true
          //  && scrollController.position.outOfRange && scrollController.offset - maxScrollExtent > 40
          ) {
        setState(() {
          showFAB = false;
        });
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (showFAB == false) {
        setState(() {
          showFAB = true;
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomizationProvider>(context).setCurrentPhoneData(
      phoneID: widget.phoneID,
      phoneBrandIndex: widget.phone.getPhoneBrandIndex,
      phoneIndex: widget.phone.getPhoneIndex,
    );

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
          resizeToAvoidBottomPadding: false,
          appBar: buildAppBar(),
          body: ShowCaseWidget(
            builder: Builder(
              builder: (context) => EditPhonePageBody(
                scrollController: scrollController,
                flipCardKey: flipCardKey,
                phoneID: widget.phoneID,
                phone: widget.phone,
              ),
            ),
          ),
          floatingActionButton: buildFAB(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.phone.getPhoneName),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(LineAwesomeIcons.angle_left),
        onPressed: () {
          if (!flipCardKey.currentState.isFront) {
            flipPhoneAndPop();
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget buildFAB() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOutSine,
      height: showFAB ? 56.0 : 0.0,
      child: FloatingActionButton(
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: showFAB ? 1.0 : 0.0,
            child: Icon(LineAwesomeIcons.camera)),
        onPressed: () {
          Provider.of<CustomizationProvider>(context).resetCurrentValues();
          if (!flipCardKey.currentState.isFront) {
            flipCardKey.currentState.controller.reverse().then((v) {
              flipCardKey.currentState.isFront = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PictureModePage(
                    phone: widget.phone,
                    phoneID: widget.phoneID,
                  ),
                ),
              );
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PictureModePage(
                  phone: widget.phone,
                  phoneID: widget.phoneID,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void flipPhoneAndPop() {
    flipCardKey.currentState.controller.reverse().then((v) {
      flipCardKey.currentState.isFront = true;
      Navigator.pop(context);
    });
  }

  Future<bool> onWillPop() {
    if (!flipCardKey.currentState.isFront) {
      flipPhoneAndPop();
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class EditPhonePageBody extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey<FlipCardState> flipCardKey;
  final dynamic phone;
  final int phoneID;

  const EditPhonePageBody({
    this.scrollController,
    this.flipCardKey,
    this.phoneID,
    this.phone,
  });

  @override
  _EditPhonePageBodyState createState() => _EditPhonePageBodyState();
}

class _EditPhonePageBodyState extends State<EditPhonePageBody> {
  static Box settingsBox = Hive.box(SettingsDatabase.settings);
  bool showTips = settingsBox.get(SettingsDatabase.editPageTipsKey) == 0;

  GlobalKey flipTipKey = GlobalKey();
  GlobalKey swipeTipKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (showTips) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase([flipTipKey, swipeTipKey]));
      settingsBox.put(SettingsDatabase.editPageTipsKey, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: MyPhoneHeaderDelegate(
            minHeight: kScreenAwareSize(1.0, context),
            maxHeight: kScreenAwareSize(475.0, context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ValueListenableBuilder(
                valueListenable: PhoneDatabase.phonesBox.listenable(),
                builder: (context, box, child) {
                  return floatingTip(
                    key: flipTipKey,
                    title: 'Tip: Specs!',
                    description: 'Flip the phone to view some of its specs',
                    child: Hero(
                      tag: widget.phoneID,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) => flipPhone(details),
                        child: FlipCard(
                          flipOnTouch: false,
                          speed: 300,
                          key: widget.flipCardKey,
                          front: widget.phone,
                          back: widget.phone.getPhoneFront,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildColorButtonsListView(context),
              SizedBox(
                height:
                    // showFAB ? 80.0 :
                    24.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildColorButtonsListView(BuildContext context) {
    Map textures = Provider.of<CustomizationProvider>(context).currentTextures;
    Map colors = Provider.of<CustomizationProvider>(context).currentColors;

    return floatingTip(
      key: swipeTipKey,
      title: 'Tip: Reset, Copy & Paste!',
      description: 'Swipe left or right on the tiles for more actons',
      child: ListView.builder(
        itemCount: colors.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return CustomizationPickerTile(
            colors: colors,
            textures: textures,
            index: i,
            noTexture: i > textures.length - 1,
          );
        },
      ),
    );
  }

  Widget floatingTip({
    GlobalKey key,
    String title,
    String description,
    Widget child,
  }) {
    return Showcase(
      key: key,
      overlayOpacity: 0.0,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // title: title,
      titleTextStyle: kTitleTextStyle.copyWith(
        color: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
      ),
      description: description,
      descTextStyle: kTitleTextStyle.copyWith(
        color: kBrightnessAwareColor(context,
            lightColor: Colors.white, darkColor: Colors.black),
        fontSize: 14.0,
      ),
      showcaseBackgroundColor: kBrightnessAwareColor(context,
          lightColor: Colors.black, darkColor: Colors.white),
      child: child,
    );
  }

  void flipPhone(DragUpdateDetails details) {
    if (details.delta.dx > 0 && !widget.flipCardKey.currentState.isFront) {
      widget.flipCardKey.currentState.toggleCard();
    } else if (details.delta.dx < 0 &&
        widget.flipCardKey.currentState.isFront) {
      widget.flipCardKey.currentState.toggleCard();
    }
  }
}
