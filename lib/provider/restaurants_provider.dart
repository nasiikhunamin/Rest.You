import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yourest/data/model/restaurant.dart';
import 'package:yourest/data/api/api_services.dart';
import 'package:yourest/utils/exception.dart';
import 'package:yourest/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late RestaurantsResult _restaurantsResult, _searchResult;
  RestaurantResult? _restaurantResult;

  late ResultState _stateList,
      _stateDetail = ResultState.loading,
      _stateSearch = ResultState.loading;
  String _message = "";

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;

  RestaurantsResult get search => _searchResult;

  RestaurantResult? get detail => _restaurantResult;

  ResultState get stateList => _stateList;

  ResultState get stateDetail => _stateDetail;

  ResultState get stateSearch => _stateSearch;

  Future<dynamic> fetchAllRestaurants() async {
    try {
      _stateList = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _stateList = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _stateList = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } on SocketException {
      _stateList = ResultState.error;
      _message = "Internet Connection Failed!";
      notifyListeners();
    } catch (e) {
      _stateList = ResultState.error;
      notifyListeners();
      throw ApiException(_message);
    }
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _stateDetail = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestaurant(id);

      if (restaurant.restaurant == null) {
        _stateDetail = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _stateDetail = ResultState.hasData;
        notifyListeners();
        _restaurantResult = restaurant;
        return _restaurantResult;
      }
    } on SocketException {
      _stateDetail = ResultState.error;
      _message = "Internet Connection Failed!";
      notifyListeners();
    } catch (e) {
      _stateDetail = ResultState.error;
      notifyListeners();
      throw ApiException(_message);
    }
  }

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _stateSearch = ResultState.loading;
      notifyListeners();
      if (query.isNotEmpty) {
        final restaurant = await apiService.searchRestaurant(query);
        if (restaurant.restaurants.isEmpty) {
          _stateSearch = ResultState.noData;
          notifyListeners();
          return _message = "Empty Data";
        } else {
          _stateSearch = ResultState.hasData;
          notifyListeners();
          return _searchResult = restaurant;
        }
      } else {
        _stateSearch = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      }
    } on SocketException {
      _stateSearch = ResultState.error;
      _message = "Internet Connection Failed!";
      notifyListeners();
    } catch (e) {
      _stateSearch = ResultState.error;
      notifyListeners();
      throw ApiException(_message);
    }
  }
}
