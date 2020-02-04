import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobware/widgets/app_widgets/show_up_widget.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  int _delay = 200;
  int _selectedTileIndex = 0;

  Map<String, IconData> _myDrawerTiles = {
    'Home': LineAwesomeIcons.home,
    'Explore': LineAwesomeIcons.rocket,
    'Tutorials': LineAwesomeIcons.book,
    'Settings': LineAwesomeIcons.cog,
    'Help': LineAwesomeIcons.question_circle,
  };

  List<IconData> _socialMediaButtons = [
    LineAwesomeIcons.facebook,
    LineAwesomeIcons.twitter,
    LineAwesomeIcons.github,
    LineAwesomeIcons.linkedin,
  ];

  void _selectTile(index) {
    setState(() {
      _selectedTileIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),
        centerTitle: true,
      ),
      drawer: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: _deviceHeight - 116.0,
            width: _deviceWidth - 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.3),
                    blurRadius: 10.0,
                    offset: Offset(5.0, 0.0)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ShowUp(
                    delay: 100,
                    direction: ShowUpFrom.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              'assets/images/fluttercommgh_icon.jpg'),
                          radius: 50.0,
                        ),
                        ListTile(
                          title: Text(
                            'Flutter Community GH',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                          subtitle: Text(
                            '129 Participants',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    _myDrawerTiles.length,
                    (i) {
                      return drawerListTile(
                        title: _myDrawerTiles.keys.elementAt(i),
                        icon: _myDrawerTiles.values.elementAt(i),
                        extraDelay: 10 * 1,
                        isSelected: _selectedTileIndex == i,
                        onTap: () => _selectTile(i),
                      );
                    },
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  height: 72.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      _socialMediaButtons.length,
                      (i) {
                        return ShowUp(
                          delay: _delay + (50 * i),
                          child: IconButton(
                            icon: Icon(
                              _socialMediaButtons[i],
                              color: i.isEven ? Colors.purple : Colors.blue,
                              size: 28.0,
                            ),
                            onPressed: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
      drawerScrimColor: Colors.transparent,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 65.0,
              child: Image.asset('assets/images/IMG_20190907_075937.jpg'),
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              child: Image.asset('assets/images/fluttercommgh_banner.png'),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerListTile({
    String title,
    IconData icon,
    Function onTap,
    int extraDelay = 100,
    bool isSelected = false,
  }) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: isSelected ? 1 : 0,
          duration: Duration(milliseconds: 600),
          curve: Curves.ease,
          child: Container(
            margin: EdgeInsets.only(right: 8.0),
            padding: EdgeInsets.only(left: 8.0),
            height: 58.0,
            decoration: isSelected
                ? BoxDecoration(
                    color: Colors.teal,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100.0),
                      bottomRight: Radius.circular(100.0),
                    ),
                  )
                : null,
          ),
        ),
        ShowUp(
          delay: _delay + extraDelay,
          direction: ShowUpFrom.left,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            leading:
                Icon(icon, color: isSelected ? Colors.white : Colors.black),
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
