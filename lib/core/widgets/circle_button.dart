import 'package:flutter/material.dart';

Widget circleButton({
  required double buttonWidth,
  required double buttonHeight,
  required IconData icon,
  required Color iconColor,

  required Function() onPressed,
}) {
  return Material(
    color: Colors.transparent,
    child: Ink(
      decoration: BoxDecoration(
        color: Color.fromRGBO(208, 208, 208, 0.24),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
            color: Color.fromRGBO(208, 208, 208, 0.24),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: buttonWidth / 2, color: iconColor),
        ),
      ),
    ),
  );
}
