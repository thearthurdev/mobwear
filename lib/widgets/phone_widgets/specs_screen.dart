import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobwear/services/phone_specs.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/circle_accent_button.dart';

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
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
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
                    CircleAccentButton(icon: LineAwesomeIcons.gears),
                    SizedBox(height: 8.0),
                    Text('No specs found', style: kTitleTextStyle),
                    SizedBox(height: 4.0),
                    Text('Try again later', style: kSubtitleTextStyle),
                  ],
                );
              }
              List specsList = snapshot.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: GridView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAccentButton(
                            icon: specIcons[i].icon,
                            index: i,
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
                  ),
                ],
              );
            },
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(LineAwesomeIcons.angle_left),
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
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      CircleAccentButton(
                        icon: specIcons[selectedSpec].icon ?? Icons.close,
                        index: selectedSpec ?? 0,
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
                          spec ?? 'No data found',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: spec == null
                                ? kBrightnessAwareColor(context,
                                    lightColor: Colors.black38,
                                    darkColor: Colors.white38)
                                : null,
                            fontSize: 18.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
