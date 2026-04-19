import 'package:flutter/widgets.dart';

// ------------- //
// Widget overview //
// A divider widget that can be used to divide between sections inside the app
// This widget offers default parameters (height and colors),
//but is still changeable for new styles during programming
// ------------- //

Widget divider({double height = 1, Color color = const Color(0xFFEAD6C8)}) {
  return Container(height: height, color: color);
}
