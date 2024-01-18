import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yourest/common/constant.dart';
import 'package:yourest/widget/snackbar.dart';
import '../model/restaurant.dart';

class ApiService {
  Future<RestaurantsResult> getListRestaurant() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load List Restaurants");
    }
  }

  Future<RestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant Detail");
    }
  }

  Future<RestaurantsResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Searched Restaurant");
    }
  }

  Future<Restaurant> getRandomRestaurant() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      final random = Random();
      List<Restaurant> listRestaurant =
          RestaurantsResult.fromJson(json.decode(response.body)).restaurants;
      Restaurant restaurant =
          listRestaurant[random.nextInt(listRestaurant.length)];
      return restaurant;
    } else {
      throw Exception("Failed Load Data Restaurant");
    }
  }
}

Future<void> postReview({
  required String restaurantId,
  required String name,
  required String review,
  required BuildContext context,
}) async {
  final scaffoldMessenger = getScaffoldMessenger(context);

  try {
    final body = {
      "id": restaurantId,
      "name": name,
      "review": review,
    };
    final response = await http.post(Uri.parse("$baseUrl/review"), body: body);

    if (response.statusCode == 201) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("Review added successfully!"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      throw Exception("Failed to Send Review Restaurant Data");
    }
  } catch (e) {
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text("Failed to add review. Please try again."),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
