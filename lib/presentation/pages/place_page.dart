import 'package:flutter/material.dart';
import 'package:tourism_app/core/widgets/circle_button.dart';
import 'package:tourism_app/models/place.dart';

class PlacePage extends StatefulWidget {
  final Place place;

  const PlacePage({super.key, required this.place});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 403,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: PageView.builder(
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Image.network(
                              'http://10.254.28.189:8000/storage/${widget.place.images[index].imagePath}',
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount: widget.place.images.length,
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned.fill(
                            child: IgnorePointer(
                              ignoring: true,
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
                          ),

                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: circleButton(
                                buttonWidth: 56,
                                buttonHeight: 56,
                                icon: Icons.arrow_back_ios_new_rounded,
                                iconColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),

                          Positioned(
                            child: IgnorePointer(
                              ignoring: true,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        Text(
                                          widget.place.location,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      widget.place.name,
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                spacing: 6,
                children: [
                  Text("التقييم:", style: TextStyle(fontSize: 20)),
                  SizedBox(
                    width: 200,
                    height: 25,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF4E4E4E),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Icon(
                            Icons.star_rounded,
                            color: Colors.amberAccent,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 4);
                      },
                      itemCount: widget.place.rating,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("تفاصيل:", style: TextStyle(fontSize: 20)),
                  Text(widget.place.description),
                ],
              ),
              SizedBox(height: 24),
              Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("معرض الصور:", style: TextStyle(fontSize: 20)),
                  SizedBox(
                    width: double.infinity,
                    height: 120 * 1.5,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 152 * 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              "http://10.254.28.189:8000/storage/${widget.place.images[index].imagePath}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemCount: widget.place.images.length,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
