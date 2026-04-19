import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/core/widgets/circle_button.dart';
import 'package:tourism_app/core/widgets/location_card.dart';
import 'package:tourism_app/presentation/pages/place_page.dart';
import 'package:tourism_app/providers/auth.dart';
import 'package:tourism_app/providers/category_provider.dart';

class CategoryPage extends StatefulWidget {
  final int categoryId;

  const CategoryPage({super.key, required this.categoryId});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final auth = Provider.of<Auth>(context, listen: false);
      final token = auth.token;

      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).fetchPlacesInCategory(token: token, categoryID: widget.categoryId);
    });
  }

  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final category = categoryProvider.categories.firstWhere(
      (category) => category.id == widget.categoryId,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 403,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(32),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'http://10.254.28.189:8000/storage/${category.image}',
                        fit: BoxFit.cover,
                      ),
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
                        padding: const EdgeInsets.all(24.0),
                        child: Align(
                          alignment: AlignmentGeometry.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              circleButton(
                                buttonWidth: 56,
                                buttonHeight: 56,
                                icon: Icons.arrow_back_ios_new_rounded,
                                iconColor: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Spacer(),
                              Text(
                                category.name,
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
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24,
                        right: 24,
                      ),
                      child: Text(
                        category.description,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),

                    Consumer<CategoryProvider>(
                      builder: (context, placesProvider, child) {
                        if (placesProvider.placesLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.greenAccent,
                            ),
                          );
                        }

                        if (placesProvider.places.isEmpty) {
                          return Center(child: Text("لا يوجد أماكن حالياً"));
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: placesProvider.places.length,

                          itemBuilder: (context, index) {
                            final place = placesProvider.places[index];

                            return Padding(
                              padding: index % 2 == 0
                                  ? EdgeInsetsGeometry.only(left: 8, bottom: 16)
                                  : EdgeInsetsGeometry.only(
                                      right: 8,
                                      bottom: 16,
                                    ),
                              child: locationCard(
                                imagePath: place.images.isEmpty
                                    ? 'assets/images/Aleppo2.jpg'
                                    : "http://10.254.28.189:8000/storage/${place.images[0].imagePath}",
                                locationName: place.name,
                                location: place.location,
                                rating: place.rating,

                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlacePage(place: place),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
