import 'package:tourism_app/models/image.dart';

class Place {
  int id;
  String name;
  String description;
  int rating;
  String location;
  int categoryID;
  List<PlaceImage> images;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.location,
    required this.categoryID,
    required this.images,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rating: json['rateing'],
      location: json['location'],
      categoryID: json['category_id'],
      images: (json['images'] as List)
          .map((imageJson) => PlaceImage.fromJson(imageJson))
          .toList(),
    );
  }
}
