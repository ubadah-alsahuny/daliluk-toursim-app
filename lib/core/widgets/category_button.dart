import 'package:flutter/material.dart';

Widget categoryButton({
  required String categoryTitle,
  required String categoryImagePath,
  Color buttonColor = Colors.white,

  required Function() onPressed,
}) {
  BorderRadius borderRadius = BorderRadius.circular(50);

  return Material(
    color: Colors.transparent,
    child: Ink(
      decoration: BoxDecoration(color: buttonColor, borderRadius: borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Container(
                  height: 62,
                  width: 62,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      categoryImagePath,
                      width: 57,
                      height: 57,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, StackTrace) {
                        print("IMAGE ERROR: $error");
                        return const Icon(Icons.broken_image);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    categoryTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E4E4E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
