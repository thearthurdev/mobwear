// import 'package:flutter/material.dart';
// import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
// import 'package:mobwear/data/models/aspect_ratio_model.dart';
// import 'package:mobwear/data/models/brand_icon_model.dart';
// import 'package:mobwear/data/models/position_model.dart';
// import 'package:mobwear/data/models/texture_model.dart';
// import 'package:mobwear/providers/customization_provider.dart';
// import 'package:mobwear/utils/constants.dart';
// import 'package:provider/provider.dart';

// class PictureCanvas extends StatefulWidget {
//   final GlobalKey<State<StatefulWidget>> captureKey;
//   final Matrix4 matrix;
//   final dynamic phone;
//   final int phoneID;
//   final Color initRandomColor;

//   const PictureCanvas({
//     @required this.captureKey,
//     @required this.matrix,
//     @required this.phone,
//     @required this.phoneID,
//     @required this.initRandomColor,
//   });

//   @override
//   _PictureCanvasState createState() => _PictureCanvasState();
// }

// class _PictureCanvasState extends State<PictureCanvas> {
//   Color initRandomColor, backgroundColor;
//   MyTexture backgroundTexture;

//   GlobalKey matrixDetectorKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     initRandomColor = widget.initRandomColor;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Matrix4 matrix = widget.matrix;
//     return Consumer<CustomizationProvider>(
//       builder: (context, provider, child) {
//         backgroundColor = provider.currentColor ?? initRandomColor;
//         backgroundTexture = MyTexture(
//           asset: provider.currentTexture,
//           blendColor: provider.currentBlendColor ?? Colors.deepOrange,
//           blendModeIndex: provider.currentBlendModeIndex ?? 0,
//         );

//         return
//       },
//     );
//   }
// }
