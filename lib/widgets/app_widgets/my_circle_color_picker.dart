// child: Stack(
//   children: <Widget>[
//     Theme(
//       data: Theme.of(context).copyWith(
//         textTheme: TextTheme(
//           caption: TextStyle(color: Colors.transparent),
//         ),
//       ),
//       child: Center(
//         child: CircleColorPicker(
//           initialColor: widget.selectedColor,
//           onChanged: (color) {
//             setState(() {
//               print(color);
//               colorPicked = color;
//             });
//           },
//         ),
//       ),
//     ),
//     Positioned(
//       top: 50.0,
//       left: 130.0,
//       child: Container(
//         width: 100.0,
//         height: 40.0,
//         child: TextField(
//           controller: textFieldController,
//           autocorrect: false,
//           enableInteractiveSelection: false,
//           textCapitalization: TextCapitalization.characters,
//           textAlign: TextAlign.center,
//           maxLength: 9,
//           style: TextStyle(
//             fontFamily: 'Quicksand',
//             fontWeight: FontWeight.bold,
//             fontSize: 16.0,
//           ),
//           decoration: InputDecoration(
//             counter: Offstage(),
//             hintText: colorPicked == null
//                 ? '#${kGetColorString(widget.selectedColor)}'
//                 : '#${kGetColorString(colorPicked)}',
//             hintStyle: TextStyle(
//               fontFamily: 'Quicksand',
//               fontSize: 16.0,
//             ),
//           ),
//           onSubmitted: (value) {
//             String valueString = '0x${value.substring(1)}';
//             print(valueString);
//             setState(() {
//               colorPicked = Color(int.parse(valueString));
//             });
//           },
//         ),
//       ),
//     ),
//   ],
// ),
