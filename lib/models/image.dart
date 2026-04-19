class PlaceImage {
  int id;
  int placeID;
  String imagePath;

  PlaceImage({
    required this.id,
    required this.placeID,
    required this.imagePath,
  });

  factory PlaceImage.fromJson(Map<String, dynamic> json) {
    return PlaceImage(
      id: json['id'],
      placeID: json['place_id'],
      imagePath: json['image_path'],
    );
  }
}
