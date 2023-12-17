import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yourest/model/local_restaurant.dart';
import 'package:yourest/widget/button_banner.dart';
import 'package:yourest/widget/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  ///Menghapus flutter native screen
  void initialization() async {
    FlutterNativeSplash.remove();
  }

  Future<String> _loadLocalData() async {
    return await DefaultAssetBundle.of(context)
        .loadString('assets/local_restaurant.json');
  }

  Future<List<Restaurant>> _fetchRestaurants() async {
    String jsonData = await _loadLocalData();
    List<dynamic> data = json.decode(jsonData)['restaurants'];
    List<Restaurant> restaurants =
        data.map((json) => Restaurant.fromJson(json)).toList();
    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 1 / 2 / 1.7,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.sizeOf(context).width,
                    color: const Color(0xff477680),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Welcome, Nasikhun",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.notifications,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Find best restaurant around you.",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 50,
                    right: 50,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            offset: const Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Colors.grey[300],
                          ),
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonBanner(
                    title: "Populer",
                  ),
                  ButtonBanner(
                    title: "Bintang 4.0+",
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Restaurant>>(
              future: _fetchRestaurants(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Restaurant> restaurants = snapshot.data!;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return CustomCard(restaurant: restaurants[index]);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
