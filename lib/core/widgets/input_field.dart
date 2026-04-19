import 'package:flutter/material.dart';

Widget inputField({
  required String placeholder,
  required IconData icon,
  foregroundColor = const Color(0xFF7A6A60),
  backgroundColor = Colors.transparent,
  iColor = Colors.white,
  bColor = Colors.transparent,
  double iHeight = 50,
  double bWidth = 0,
  double pTSize = 14,
  bool isObscure = false,
  bool shouldSave = true,
  Function(String)? onSaved,
}) {
  return Container(
    height: iHeight,
    decoration: BoxDecoration(
      color: iColor,
      border: BoxBorder.all(width: bWidth, color: bColor),
      borderRadius: BorderRadius.circular(32),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          obscureText: isObscure,
          cursorColor: Color(0xFF7A6A60),
          decoration: InputDecoration(
            border: InputBorder.none,
            hint: Text(
              placeholder,
              style: TextStyle(color: Color(0xFF7A6A60), fontSize: pTSize),
            ),
            icon: Icon(icon, color: foregroundColor),
          ),
          onSaved: shouldSave
              ? (value) {
                  if (onSaved != null && value != null) {
                    onSaved(value);
                  }
                }
              : null,
        ),
      ),
    ),
  );
}
