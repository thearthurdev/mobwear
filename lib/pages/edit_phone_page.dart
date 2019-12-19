import 'package:flutter/material.dart';
import 'package:mobware/providers/phones_data.dart';
import 'package:mobware/widgets/color_picker_button.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';

class EditPhonePage extends StatefulWidget {
  static String id = 'EditPhonePage';
  final phone;
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

class _EditPhonePageState extends State<EditPhonePage> {
  GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

  int flipCount = 0;

  @override
  Widget build(BuildContext context) {
    Widget phoneBack = widget.phone;
    Widget phoneFront = widget.phone.getPhoneFront;
    String phoneName = widget.phone.getPhoneName;
    Map colors = Provider.of<PhonesData>(context)
        .getColors(widget.phoneList, widget.phoneIndex);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(phoneName),
          centerTitle: true,
        ),
        body: Container(
          // height: 450.0,
          // width: 350.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Padding(
                          // padding: const EdgeInsets.all(8.0),
                          padding: EdgeInsets.zero,
                          child: Hero(
                            tag: phoneBack,
                            child: GestureDetector(
                              child: FlipCard(
                                flipOnTouch: false,
                                speed: 300,
                                key: flipCardKey,
                                front: phoneBack,
                                back: phoneFront,
                              ),
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  if (details.delta.dx > 0 &&
                                      !flipCardKey.currentState.isFront) {
                                    flipCardKey.currentState.toggleCard();
                                    flipCount++;
                                  } else if (details.delta.dx < 0 &&
                                      flipCardKey.currentState.isFront) {
                                    flipCardKey.currentState.toggleCard();
                                    flipCount++;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: flipCount < 1 ? 1.0 : 0.0,
                            child: Text(
                              'Hint: Flip the phone to view its specs',
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 24.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height - 100.0,
                        child: ListView.builder(
                          itemCount: colors.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, left: 1.0),
                              child: ColorPickerButton(
                                colorName: colors.keys.elementAt(i),
                                color: colors.values.elementAt(i),
                                onPressed: () {
                                  Provider.of<PhonesData>(context).changeColor(
                                    context,
                                    colors,
                                    colors.keys.elementAt(i),
                                    colors.values.elementAt(i),
                                    i,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: onWillPop,
    );
  }

  Future<bool> onWillPop() {
    if (!flipCardKey.currentState.isFront) {
      flipCardKey.currentState.toggleCard();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
