import 'dart:ui';

import 'package:flutter/material.dart';

Widget popularLocationCard({
  required String imagePath,
  required String locationName,
  required String location,
  required String rating,
}) {
  final double widgetWidth = 350;

  return SizedBox(
    width: widgetWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(32),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(imagePath, fit: BoxFit.cover),
                ),

                Positioned.fill(
                  child: Container(
                    width: double.infinity,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(32),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 50,
                                  sigmaY: 50,
                                ),
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13.0,
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 5,
                                      children: [
                                        Text(
                                          rating,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amberAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: widgetWidth * 0.83,
                              child: Text(
                                locationName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              location,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
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
      ],
    ),
  );
}
