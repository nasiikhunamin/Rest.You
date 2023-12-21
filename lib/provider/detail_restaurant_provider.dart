import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yourest/model/restaurant_detail.dart';

import 'package:yourest/services/restaurant_services.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantServices restaurantServices;
  String id;

  RestaurantDetailProvider(
      {required this.restaurantServices, required this.id}) {
    _fetchRestaurantDetail();
  }

  late RestaurantDetail _restaurantDetailResult;
  late ResultState _state;

  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaurantDetailResult;
  ResultState get state => _state;

  get restaurant => null;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await restaurantServices.getRestaurantDetail(id);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
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
