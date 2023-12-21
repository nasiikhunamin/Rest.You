import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yourest/model/restaurant_search.dart';
import 'package:yourest/services/restaurant_services.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  RestaurantServices restaurantServices = RestaurantServices();
  late RestaurantSearch _restaurantResult =
      RestaurantSearch(error: false, founded: 0, restaurants: []);
  late bool _isLoading = false;
  late String _message = '';
  String get message => _message;
  bool get isLoading => _isLoading;
  RestaurantSearch get result => _restaurantResult;

  Future<dynamic> searchRestaurant(String value) async {
    try {
      _restaurantResult =
          RestaurantSearch(error: true, founded: 0, restaurants: []);
      _isLoading = true;
      notifyListeners();
      final restaurantLists =
          await restaurantServices.getRestaurantSearch(value);
      if (restaurantLists.restaurants.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return _message = 'Restaurant not found';
      } else {
        notifyListeners();
        _isLoading = false;
        return _restaurantResult = restaurantLists;
      }
    } catch (e) {
      if (e is SocketException) {
        _isLoading = false;
        notifyListeners();
        return _message = 'No internet connection';
      } else {
        _isLoading = false;
        notifyListeners();
        return _message = 'Failed to load data';
      }
    }
  }
}
