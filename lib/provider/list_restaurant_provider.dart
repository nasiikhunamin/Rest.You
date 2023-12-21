import 'dart:io';

import 'package:flutter/material.dart';

import 'package:yourest/model/restaurant_list_.dart';
import 'package:yourest/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;

  RestaurantProvider({required this.restaurantServices}) {
    _fetchAllRestaurant();
  }

  late RestaurantList _restaurantResult;
  late ResultState _state;

  String _message = '';
  String get message => _message;
  RestaurantList get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await restaurantServices.getRestaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantList;
      }
    } catch (e) {
      if (e is SocketException) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'No Internet Connection';
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed to Load Data';
      }
    }
  }
}
