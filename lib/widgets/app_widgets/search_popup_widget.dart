import 'package:flutter/material.dart';
import 'package:mobwear/services/search.dart';
import 'package:mobwear/utils/constants.dart';
import 'package:mobwear/widgets/app_widgets/no_phones_found_widget.dart';

class SearchPopupWidget extends StatelessWidget {
  final RelativeRect position;
  final double width;
  final double height;
  final double listContainerHeight;
  final double textBoxHeight;
  final Search widget;
  final Function popupListItemWidget;
  final Function onTap;
  final LayerLink _layerLink;
  final List _tempList;

  const SearchPopupWidget({
    @required this.position,
    @required this.width,
    @required this.height,
    @required this.listContainerHeight,
    @required this.textBoxHeight,
    @required this.widget,
    @required this.popupListItemWidget,
    @required this.onTap,
    @required LayerLink layerLink,
    @required List tempList,
  })  : _layerLink = layerLink,
        _tempList = tempList;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.left,
      width: width,
      child: CompositedTransformFollower(
        offset: Offset(
          0,
          height - position.bottom < listContainerHeight
              ? (textBoxHeight + 6.0)
              : -(listContainerHeight - 8.0),
        ),
        showWhenUnlinked: false,
        link: _layerLink,
        child: Container(
          height: _tempList.length < 1
              ? 130.0
              : _tempList.length > 3 ? 260.0 : _tempList.length * 76.0,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: kBrightnessAwareColor(
              context,
              lightColor: Colors.white,
              darkColor: Colors.grey[900],
            ),
            boxShadow: [
              BoxShadow(
                color: kBrightnessAwareColor(context,
                    lightColor: Colors.blueGrey.withOpacity(0.2),
                    darkColor: Colors.black26),
                blurRadius: 10.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: _tempList.isNotEmpty
                ? Scrollbar(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                      itemBuilder: (context, index) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => onTap(_tempList[index]),
                          child:
                              popupListItemWidget(_tempList.elementAt(index)),
                        ),
                      ),
                      itemCount: _tempList.length,
                    ),
                  )
                : widget.noItemsFoundWidget != null
                    ? Center(child: widget.noItemsFoundWidget)
                    : Center(child: NoPhonesFound()),
          ),
        ),
      ),
    );
  }
}
