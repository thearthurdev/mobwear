import 'package:flutter/material.dart';
import 'package:mobware/services/keyboard_visibilty.dart';
import 'package:mobware/widgets/app_widgets/search_bar.dart';
import 'package:mobware/widgets/app_widgets/search_popup_widget.dart';

typedef QueryListItemBuilder<T> = Widget Function(T item);
typedef OnItemSelected<T> = void Function(T item);
typedef QueryBuilder<T> = List<T> Function(
  String query,
  List<T> list,
);
typedef TextFieldBuilder = Widget Function(
  TextEditingController controller,
  FocusNode focus,
);

class Search<T> extends StatefulWidget {
  const Search({
    @required this.dataList,
    @required this.popupListItemBuilder,
    @required this.queryBuilder,
    Key key,
    this.onItemSelected,
    this.listContainerHeight,
    this.noItemsFoundWidget,
    this.textFieldBuilder,
  }) : super(key: key);

  final List<T> dataList;
  final QueryListItemBuilder<T> popupListItemBuilder;
  final double listContainerHeight;
  final QueryBuilder<T> queryBuilder;
  final TextFieldBuilder textFieldBuilder;
  final Widget noItemsFoundWidget;

  final OnItemSelected<T> onItemSelected;

  @override
  MySingleChoiceSearchState<T> createState() => MySingleChoiceSearchState<T>();
}

class MySingleChoiceSearchState<T> extends State<Search<T>> {
  final _controller = TextEditingController();
  List<T> _list;
  List<T> _tempList;
  bool isFocused;
  bool _showClose = false;
  FocusNode _focusNode;
  ValueNotifier<T> notifier;
  bool isRequiredCheckFailed;
  Widget textField;
  OverlayEntry overlayEntry;
  double listContainerHeight;
  final LayerLink _layerLink = LayerLink();
  final double textBoxHeight = 48;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _tempList = <T>[];
    notifier = ValueNotifier(null);
    _focusNode = FocusNode();
    isFocused = false;
    _list = List<T>.from(widget.dataList);
    _tempList.addAll(_list);

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _showClose = false;
        });
        _controller.clear();
        if (overlayEntry != null) {
          overlayEntry.remove();
        }
        overlayEntry = null;
      } else {
        _tempList
          ..clear()
          ..addAll(_list);
        if (overlayEntry == null) {
          onTap();
        } else {
          overlayEntry.markNeedsBuild();
        }
      }
    });

    _controller.addListener(() {
      final text = _controller.text;
      if (text.trim().isNotEmpty) {
        _tempList.clear();
        final filterList = widget.queryBuilder(text, widget.dataList);
        if (filterList == null) {
          throw Exception(
            "Filtered List cannot be null. Pass empty list instead",
          );
        }
        _tempList.addAll(filterList);
        if (overlayEntry == null) {
          onTap();
        } else {
          overlayEntry.markNeedsBuild();
        }
      } else {
        _tempList
          ..clear()
          ..addAll(_list);
        if (overlayEntry == null) {
          onTap();
        } else {
          overlayEntry.markNeedsBuild();
        }
      }
    });

    KeyboardVisibilityNotification().addNewListener(
      onChange: (visible) {
        if (!visible) {
          _focusNode.unfocus();
        }
      },
    );
  }

  @override
  void didUpdateWidget(Search oldWidget) {
    if (oldWidget.dataList != widget.dataList) {
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    listContainerHeight = _tempList.length < 1
        ? 130.0
        : _tempList.length > 3 ? 260.0 : _tempList.length * 76.0;
    textField = widget.textFieldBuilder != null
        ? widget.textFieldBuilder(_controller, _focusNode)
        : SearchBar(
            controller: _controller,
            focusNode: _focusNode,
            showClose: _showClose,
            overlayEntry: overlayEntry,
            onCloseTap: () {
              if (overlayEntry != null) {
                overlayEntry.remove();
              }
              overlayEntry = null;
              _controller.clear();
              _focusNode.unfocus();
              setState(() {
                _showClose = false;
                isFocused = false;
                isRequiredCheckFailed = false;
              });
            },
          );

    return CompositedTransformTarget(
      link: _layerLink,
      child: textField,
    );
  }

  void onDropDownItemTap(T item) {
    if (overlayEntry != null) {
      overlayEntry.remove();
    }
    overlayEntry = null;
    _controller.clear();
    _focusNode.unfocus();
    setState(() {
      notifier.value = item;
      _showClose = false;
      isFocused = false;
      isRequiredCheckFailed = false;
    });
    if (widget.onItemSelected != null) {
      widget.onItemSelected(item);
    }
  }

  void onTap() {
    final RenderBox textFieldRenderBox = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final width = textFieldRenderBox.size.width;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        textFieldRenderBox.localToGlobal(
          textFieldRenderBox.size.topLeft(Offset.zero),
          ancestor: overlay,
        ),
        textFieldRenderBox.localToGlobal(
          textFieldRenderBox.size.topRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    setState(() {
      _showClose = true;
    });
    overlayEntry = OverlayEntry(
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        return SearchPopupWidget(
          position: position,
          width: width,
          height: height,
          listContainerHeight: listContainerHeight,
          textBoxHeight: textBoxHeight,
          layerLink: _layerLink,
          tempList: _tempList,
          widget: widget,
          popupListItemWidget: (index) => widget.popupListItemBuilder(index),
          onTap: (item) => onDropDownItemTap(item),
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
  }
}
