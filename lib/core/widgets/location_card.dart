import 'package:flutter/material.dart';

Widget locationCard({
  required String imagePath,
  required String locationName,
  required String location,
  required int rating,

  required Function() onPressed,
}) {
  final double widgetWidth = 180;

  return SizedBox(
    width: widgetWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 245,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(32),
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(32),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: imagePath.startsWith('http')
                        ? Image.network(imagePath, fit: BoxFit.cover)
                        : Image.asset(imagePath, fit: BoxFit.cover),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            const Color.fromRGBO(0, 0, 0, 0.75),
                            Colors.transparent,
                          ],
                          begin: AlignmentGeometry.bottomCenter,
                          end: AlignmentGeometry.center,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            locationName,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: widgetWidth * 0.63,
                                child: Text(
                                  location,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "$rating",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amberAccent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
