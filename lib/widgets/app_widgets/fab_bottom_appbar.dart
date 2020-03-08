import 'package:flutter/material.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/show_up_widget.dart';

class FABBottomAppBarItem {
  final IconData iconData;

  FABBottomAppBarItem(this.iconData);
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.foregroundColor,
    this.selectedColor,
    this.notchedShape,
    this.onItemSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color foregroundColor;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onItemSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  _updateIndex(int index) {
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: kBrightnessAwareColor(context,
          lightColor: Colors.white, darkColor: Color(0xFF0C0C0C)),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: kTitleTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = widget.foregroundColor;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () => onPressed(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ShowUp(
                    delay: 100 * index,
                    child: Icon(item.iconData,
                        color: color, size: widget.iconSize),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
