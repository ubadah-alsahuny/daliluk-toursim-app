import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/core/widgets/category_button.dart';
import 'package:tourism_app/core/widgets/circle_button.dart';
import 'package:tourism_app/core/widgets/input_field.dart';
import 'package:tourism_app/core/widgets/location_card.dart';
import 'package:tourism_app/core/widgets/popular_location_card.dart';
import 'package:tourism_app/presentation/pages/category_page.dart';
import 'package:tourism_app/providers/auth.dart';
import 'package:tourism_app/providers/category_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final auth = Provider.of<Auth>(context, listen: false);
      final token = auth.token;

      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).fetchCategories(token: token);

      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).fetchPlacesInAllCategories(token: token);
    });
  }

  Widget build(BuildContext context) {
    final double horizontalPadding = 16.0;

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 204,
                            child: Text(
                              "ابحث عن مكان سياحتك التالي!",
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                          Spacer(),
                          circleButton(
                            buttonHeight: 76,
                            buttonWidth: 76,
                            icon: Icons.directions_walk_rounded,
                            iconColor: Colors.black,

                            onPressed: () async {
                              await Provider.of<Auth>(
                                context,
                                listen: false,
                              ).logout();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        spacing: 14,
                        children: [
                          Expanded(
                            child: inputField(
                              placeholder: "ابحث عن مكان",
                              icon: Icons.search_rounded,
                              iColor: Colors.transparent,
                              iHeight: 60,
                              bColor: Color(0xFFEEEEEE),
                              backgroundColor: Color.fromRGBO(
                                208,
                                208,
                                61,
                                0.816,
                              ),
                              bWidth: 2,
                              pTSize: 16,
                            ),
                          ),
                          circleButton(
                            buttonHeight: 60,
                            buttonWidth: 60,
                            icon: Icons.filter_alt_rounded,
                            iconColor: Color(0xFF808080),

                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                Column(
                  children: [
                    Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        if (categoryProvider.categoriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (categoryProvider.categories.isEmpty) {
                          return const Text("لا يوجد فئات حالياً");
                        }

                        return SizedBox(
                          height: 62,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: categoryProvider.categories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  categoryProvider.categories[index];

                              return Padding(
                                padding: index == 0
                                    ? EdgeInsets.only(right: horizontalPadding)
                                    : index ==
                                          categoryProvider.categories.length - 1
                                    ? EdgeInsets.only(left: horizontalPadding)
                                    : const EdgeInsetsGeometry.all(0),
                                child: categoryButton(
                                  categoryTitle: category.name,
                                  categoryImagePath:
                                      'http://10.254.28.189:8000/storage/${category.image}',
                                  buttonColor: Color(0xFFF2F2F2),

                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryPage(
                                          categoryId: category.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 8);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: 24),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    "إقضِ بعض الوقت في الطبيعة",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                SizedBox(height: 12),

                Consumer<CategoryProvider>(
                  builder: (context, allPlacesProvider, child) {
                    if (allPlacesProvider.allPlacesLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (allPlacesProvider.allPlaces.isEmpty) {
                      return Center(child: Text("NULL"));
                    }

                    final naturePlaces = allPlacesProvider.allPlaces
                        .where((place) => place.categoryID == 3)
                        .toList();

                    if (naturePlaces.isEmpty) {
                      return Center(
                        child: Text("لا يوجد أماكن لقضاء الوقت فيها حالياً"),
                      );
                    }

                    return SizedBox(
                      height: 270,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: naturePlaces.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 16);
                        },
                        itemBuilder: (context, index) {
                          final place = naturePlaces[index];
                          return Padding(
                            padding: index == 0
                                ? EdgeInsetsGeometry.only(
                                    right: horizontalPadding,
                                  )
                                : index == naturePlaces.length - 1
                                ? EdgeInsetsGeometry.only(
                                    left: horizontalPadding,
                                  )
                                : const EdgeInsets.all(0),
                            child: locationCard(
                              imagePath: place.images.isEmpty
                                  ? "assets/images/Aleppo2.jpg"
                                  : "http://10.254.28.189:8000/storage/${place.images[0].imagePath}",
                              locationName: place.name,
                              location: place.location,
                              rating: place.rating,

                              onPressed: () {},
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                SizedBox(height: 24),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text("أشهر الأماكن", style: TextStyle(fontSize: 20)),
                ),

                SizedBox(height: 12),

                Consumer<CategoryProvider>(
                  builder: (context, allPlacesProvider, child) {
                    if (allPlacesProvider.allPlacesLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (allPlacesProvider.allPlaces.isEmpty) {
                      return Center(child: Text("لا يوجد أماكن لعرضها"));
                    }

                    final popularPlaces = allPlacesProvider.allPlaces
                        .where((place) => place.rating == 5)
                        .toList();

                    if (popularPlaces.isEmpty) {
                      return Center(child: Text("لا يوجد أماكن مشهورة"));
                    }

                    return SizedBox(
                      height: 270,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 4,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 16);
                        },
                        itemBuilder: (context, index) {
                          final place = popularPlaces[index];

                          return Padding(
                            padding: index == 0
                                ? EdgeInsetsGeometry.only(
                                    right: horizontalPadding,
                                  )
                                : index == popularPlaces.length - 1
                                ? EdgeInsetsGeometry.only(
                                    left: horizontalPadding,
                                  )
                                : const EdgeInsets.all(0),
                            child: popularLocationCard(
                              imagePath:
                                  "http://10.254.28.189:8000/storage/${place.images[0].imagePath}",
                              locationName: place.name,
                              location: place.location,
                              rating: "${place.rating}",
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
