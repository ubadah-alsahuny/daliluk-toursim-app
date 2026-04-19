import 'package:flutter/material.dart';

Widget submitButton({
  required String title,
  required Function() onPressed,
  Color backgroundColor = Colors.greenAccent,
  bool isLoading = false,
}) {
  return TextButton(
    onPressed: isLoading ? null : onPressed,
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        child: isLoading
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 5,
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    ),
  );
}
