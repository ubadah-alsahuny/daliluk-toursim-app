import 'package:flutter/material.dart';

Widget roundedImage(double width, String imagePath) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          spreadRadius: 5,
          blurRadius: 5,
        ),
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: Image.asset(imagePath),
  );
}
