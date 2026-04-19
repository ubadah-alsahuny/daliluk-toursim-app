import 'package:flutter/material.dart';
import 'package:tourism_app/dio.dart';
import 'package:dio/dio.dart' as dio_variable;
import 'package:tourism_app/models/category.dart';
import 'package:tourism_app/models/place.dart';

class CategoryProvider extends ChangeNotifier {
  // Private loading variables
  bool _categoriesLoading = false;
  bool _placesLoading = false;
  bool _allPlacesLoading = false;

  // Private lists for data
  List<Category> _categories = [];
  List<Place> _places = [];
  List<Place> _allPlaces = [];

  // Public getter for Private variables
  bool get categoriesLoading => _categoriesLoading;
  bool get placesLoading => _placesLoading;
  bool get allPlacesLoading => _allPlacesLoading;

  List<Category> get categories => _categories;
  List<Place> get places => _places;
  List<Place> get allPlaces => _allPlaces;

  Future<void> fetchCategories({String? token}) async {
    _categoriesLoading = true;
    notifyListeners();

    try {
      var response = await dio().get(
        'categories',
        options: dio_variable.Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data['data'] ?? [];

        _categories = data.map((json) => Category.fromJson(json)).toList();
      }
    } catch (error) {
      print(
        "There was an error in fetching data for categories, here is what happened:",
      );
      print(error);
    } finally {
      _categoriesLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPlacesInCategory({String? token, int? categoryID}) async {
    _placesLoading = true;
    _places = [];
    notifyListeners();

    try {
      var response = await dio().get(
        'categories/$categoryID/places',
        options: dio_variable.Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data['data'];

        _places = data.map((json) => Place.fromJson(json)).toList();
      }
    } catch (error) {
      print(
        "Error while fetching places for this category #$categoryID, here is what happened:",
      );
      print(error);
      _places = [];
    } finally {
      _placesLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPlacesInAllCategories({String? token}) async {
    _allPlacesLoading = true;
    notifyListeners();

    try {
      var response = await dio().get(
        'places',
        options: dio_variable.Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List data = response.data['data'];

        _allPlaces = data.map((json) => Place.fromJson(json)).toList();
      }
    } catch (error) {
      print("Error while fetching places:");
      print(error);
    } finally {
      _allPlacesLoading = false;
      notifyListeners();
    }
  }
}
