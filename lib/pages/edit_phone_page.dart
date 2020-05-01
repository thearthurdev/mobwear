import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/database/settings_database.dart';
import 'package:mobwear/pages/picture_mode_page.dart';
import 'package:mobwear/providers/customization_provider.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:mobwear/utils/my_phone_header_delegate.dart';
import 'package:mobwear/widgets/app_widgets/customization_picker_tile.dart';
import 'package:mobwear/widgets/app_widgets/flushbars.dart';
import 'package:provider/provider.dart';

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
  ScrollController scrollController1;
  ScrollController scrollController2;
  ScrollController currentController;
  bool showFAB;
  bool isWideScreen;

  static Box settingsBox = SettingsDatabase.settingsBox;
  bool showFlipTip = settingsBox.get(SettingsDatabase.flipPhoneTipKey) != 1;
  bool showSwipeTip = settingsBox.get(SettingsDatabase.flipPhoneTipKey) != 1;

  @override
  void initState() {
    super.initState();
    showFAB = true;
    scrollController1 = ScrollController();
    scrollController2 = ScrollController();
    scrollController1.addListener(scrollListener);
    scrollController2.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => showFlipTipFlushbar());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<CustomizationProvider>(context).changeEditPageStatus(true);
  }

  void showFlipTipFlushbar() {
    if (showFlipTip) {
      Future.delayed(Duration(milliseconds: 1500), () {
        flipCardKey.currentState.controller.forward();
        flipCardKey.currentState.isFront = false;
        flipCardKey.currentState.setState(() {});
        MyFlushbars.showTipFlushbar(
          context,
          title: 'Tip: Specs',
          message: 'Want to view the specs of any phone? Simply flip it over!',
          onDismiss: () {
            flipCardKey.currentState.controller.reverse();
            flipCardKey.currentState.isFront = true;
            settingsBox.put(SettingsDatabase.flipPhoneTipKey, 1);
            if (showSwipeTip) showSwipeTipFlushbar();
          },
        );
      });
    }
  }

  void showSwipeTipFlushbar() {
    void showSwipeTip() {
      MyFlushbars.showTipFlushbar(
        context,
        title: 'Tip: Reset, Copy & Paste',
        message: 'Swipe left or right on a card to access more actions',
        onDismiss: () => settingsBox.put(SettingsDatabase.swipeCardTipKey, 1),
      );
    }

    if (isWideScreen) {
      showSwipeTip();
    } else {
      double maxScrollExtent = scrollController1.position.maxScrollExtent;
      setState(() => showFAB = false);
      scrollController1
          .animateTo(
              maxScrollExtent > 400.0 ? maxScrollExtent * 0.5 : maxScrollExtent,
              duration: Duration(milliseconds: 600),
              curve: Curves.linearToEaseOut)
          .whenComplete(() => showSwipeTip());
    }
  }

  void scrollListener() {
    if (currentController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (showFAB == true) setState(() => showFAB = false);
    } else if (currentController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (showFAB == false) setState(() => showFAB = true);
    }
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isWideScreen = kIsWideScreen(context) ||
        kDeviceWidth(context) >= kDeviceHeight(context);
    currentController = isWideScreen ? scrollController2 : scrollController1;

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
          body: buildBody(),
          floatingActionButton: buildFAB(),
          floatingActionButtonLocation: isWideScreen
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.centerFloat,
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
            Provider.of<CustomizationProvider>(context)
                .changeEditPageStatus(false);
            Navigator.pop(context);
          }
        },
      ),
      // actions: <Widget>[
      //   IconButton(
      //     icon: Icon(LineAwesomeIcons.database),
      //     onPressed: () => Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => DataPage())),
      //   ),
      // ],
    );
  }

  Widget buildBody() {
    if (isWideScreen) {
      return buildWideScreenLayout();
    }

    return buildNormalLayout();
  }

  Widget buildWideScreenLayout() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: Container(
              margin: EdgeInsets.all(
                kScreenAwareSize(24.0, context),
              ),
              child: buildPhone(),
            ),
          ),
          Flexible(
            child: buildCustomizationTileList(context),
          ),
        ],
      ),
    );
  }

  Widget buildNormalLayout() {
    return CustomScrollView(
      controller: scrollController1,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: MyPhoneHeaderDelegate(
            minHeight: kScreenAwareSize(1.0, context),
            maxHeight: kScreenAwareSize(475.0, context),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: buildPhone(),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: kDeviceWidth(context) >= kTabletBreakpoint
                    ? EdgeInsets.symmetric(
                        horizontal: kScreenAwareSize(60.0, context))
                    : null,
                child: buildCustomizationTileList(context),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
    return Hero(
      tag: widget.phoneID,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => flipPhone(details),
        child: FlipCard(
          flipOnTouch: false,
          speed: 300,
          key: flipCardKey,
          front: widget.phone,
          back: widget.phone.getPhoneFront,
        ),
      ),
    );
  }

  Widget buildCustomizationTileList(BuildContext context) {
    Map textures = Provider.of<CustomizationProvider>(context).currentTextures;
    Map colors = Provider.of<CustomizationProvider>(context).currentColors;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: colors.length,
      controller: scrollController2,
      physics: isWideScreen ? null : NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return CustomizationPickerTile(
          colors: colors,
          textures: textures,
          index: i,
          noTexture: i > textures.length - 1,
        );
      },
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
          child: Icon(LineAwesomeIcons.camera),
        ),
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

  void flipPhone(DragUpdateDetails details) {
    if (details.delta.dx > 0 && !flipCardKey.currentState.isFront) {
      flipCardKey.currentState.toggleCard();
    } else if (details.delta.dx < 0 && flipCardKey.currentState.isFront) {
      flipCardKey.currentState.toggleCard();
    }
  }

  void flipPhoneAndPop() {
    flipCardKey.currentState.controller.reverse().then((v) {
      flipCardKey.currentState.isFront = true;
      Provider.of<CustomizationProvider>(context).changeEditPageStatus(false);
      Navigator.pop(context);
    });
  }

  Future<bool> onWillPop() {
    if (!flipCardKey.currentState.isFront) {
      flipPhoneAndPop();
      return Future.value(false);
    }
    Provider.of<CustomizationProvider>(context).changeEditPageStatus(false);
    return Future.value(true);
  }
}
