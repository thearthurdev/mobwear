import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/utils/constants.dart';
import 'package:mobware/utils/phoneSpecs.dart';

class SpecsScreen extends StatefulWidget {
  final String phoneBrand, phoneModel, phoneName;

  const SpecsScreen({this.phoneBrand, this.phoneModel, this.phoneName});

  @override
  _SpecsScreenState createState() => _SpecsScreenState();
}

class SpecModel {
  String name;
  IconData icon;

  SpecModel({this.name, this.icon});
}

List<SpecModel> specIcons = [
  SpecModel(name: 'Battery', icon: LineAwesomeIcons.battery_0),
  SpecModel(name: 'Camera', icon: LineAwesomeIcons.camera),
  SpecModel(name: 'Memory', icon: LineAwesomeIcons.database),
  SpecModel(name: 'Headphone Jack', icon: LineAwesomeIcons.headphones),
  SpecModel(name: 'Weight', icon: LineAwesomeIcons.balance_scale),
  SpecModel(name: 'Display', icon: LineAwesomeIcons.mobile),
];

int selectedSpec = 0;
int page = 0;
String spec;

class _SpecsScreenState extends State<SpecsScreen> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: page,
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int randomInt = Random().nextInt(10);

    return Container(
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          FutureBuilder(
            future: PhoneSpecs().getPhoneSpecs(
              brand: widget.phoneBrand,
              model: widget.phoneModel,
              device: widget.phoneName,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAccentButton(LineAwesomeIcons.cloud, randomInt),
                    SizedBox(height: 8.0),
                    Text(
                      'No Data',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }
              List specsList = snapshot.data;

              return Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        'Specs',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Righteous',
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, i) {
                      IconData icon = specIcons[i].icon;
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          child: CircleAccentButton(icon, i),
                          onTap: () {
                            pageController.animateToPage(
                              1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                            selectedSpec = i;
                            spec = specsList[i];
                            page = 1;
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 20.0),
                  child: IconButton(
                    icon: Icon(EvaIcons.arrowIosBack),
                    onPressed: () {
                      page = 0;
                      pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    CircleAccentButton(
                      specIcons[selectedSpec].icon ?? Icons.close,
                      selectedSpec ?? 0,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      specIcons[selectedSpec].name ?? 'Spec Name',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        spec ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Data retreived from\nfonoApi database',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 8.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleAccentButton extends StatelessWidget {
  final IconData icon;
  final int index;
  const CircleAccentButton(this.icon, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenAwareSize(60.0, context),
      height: kScreenAwareSize(60.0, context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.accents[index].withOpacity(0.4),
      ),
      child: Icon(
        icon,
        size: kScreenAwareSize(25.0, context),
        color: Colors.primaries[index],
      ),
    );
  }
}
