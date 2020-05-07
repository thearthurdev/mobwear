import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  static const String id = '/TestPage';

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool showCarousel;

  @override
  void initState() {
    showCarousel = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel Slider'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            showCarousel = !showCarousel;
          });
        },
        label: Text('Swap'),
        icon: Icon(Icons.refresh),
      ),
      body: Container(
        child: Center(
          child: showCarousel
              ? CarouselSlider.builder(
                  itemCount: 9,
                  itemBuilder: (context, i) {
                    return Container(
                      width: 300.0,
                      height: 400.0,
                      padding: EdgeInsets.all(16.0),
                      color: Colors.primaries.reversed.toList()[i],
                    );
                  },
                  options: CarouselOptions(
                    height: 500.0,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeOut,
                    viewportFraction: isLandscape ? 0.3 : 1.0,
                    enlargeCenterPage: isLandscape,
                  ),
                )
              : Text('Swapping...'),
        ),
      ),
    );
  }
}
