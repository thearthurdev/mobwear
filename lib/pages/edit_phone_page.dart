import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/pages/share_phone_Page.dart';
import 'package:mobware/providers/customization_provider.dart';
import 'package:mobware/providers/settings_provider.dart';
import 'package:mobware/utils/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:mobware/utils/my_phone_header_delegate.dart';
import 'package:mobware/widgets/app_widgets/customization_picker_tile.dart';
import 'package:provider/provider.dart';

class EditPhonePage extends StatefulWidget {
  static String id = '/EditPhonePage';

  final dynamic phone;
  final List phoneList;
  final int phoneIndex;

  EditPhonePage({
    this.phone,
    this.phoneList,
    this.phoneIndex,
  });

  @override
  _EditPhonePageState createState() => _EditPhonePageState();
}

class _EditPhonePageState extends State<EditPhonePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();
  ScrollController scrollController;
  bool showFAB = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (showFAB == false && scrollController.position.outOfRange) {
        setState(() {
          showFAB = true;
        });
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (showFAB == true) {
        setState(() {
          showFAB = false;
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
    Provider.of<CustomizationProvider>(context)
        .setCurrentPhone(widget.phoneList, widget.phoneIndex);
    Provider.of<SettingsProvider>(context).changeTempAutoplayValue(false);

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: buildAppBar(),
        body: buildBody(),
        floatingActionButton: buildFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.phone.getPhoneName),
      centerTitle: true,
      automaticallyImplyLeading: false,
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

  CustomScrollView buildBody() {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: MyPhoneHeaderDelegate(
            minHeight: kScreenAwareSize(1.0, context),
            maxHeight: kScreenAwareSize(475.0, context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Hero(
                tag:
                    Provider.of<CustomizationProvider>(context).currentPhone.id,
                child: GestureDetector(
                  child: FlipCard(
                    flipOnTouch: false,
                    speed: 300,
                    key: flipCardKey,
                    front: widget.phone,
                    back: widget.phone.getPhoneFront,
                  ),
                  onHorizontalDragUpdate: (details) => flipPhone(details),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildColorButtonsListView(),
              SizedBox(
                height: showFAB ? 80.0 : 24.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildFAB() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOutSine,
      height: showFAB ? 48.0 : 0.0,
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
                  builder: (context) => SharePhonePage(phone: widget.phone),
                ),
              );
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SharePhonePage(phone: widget.phone),
              ),
            );
          }
        },
      ),
    );
  }

  ListView buildColorButtonsListView() {
    Map textures = Provider.of<CustomizationProvider>(context).currentTextures;
    Map colors = Provider.of<CustomizationProvider>(context).currentColors;

    return ListView.builder(
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
