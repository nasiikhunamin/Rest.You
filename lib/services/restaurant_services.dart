import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourest/model/restaurant_detail.dart';
import 'package:yourest/model/restaurant_list_.dart';
import 'package:yourest/model/restaurant_search.dart';
import 'package:yourest/utils/constant.dart';

class RestaurantServices {
  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse('${baseurl}list'));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'Failed load data. Status Code ${response.statusCode}, Response: ${response.body}');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('${baseurl}detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'Failed to load data. Status Code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse('${baseurl}search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception(
          'Failed to load data Search. Status Code: ${response.statusCode}, Response: ${response.body}');
    }
  }
}
