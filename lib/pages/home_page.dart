import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:yourest/model/restaurant_list_.dart';
import 'package:yourest/services/restaurant_services.dart';
import 'package:yourest/widget/button_banner.dart';
import 'package:yourest/widget/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<RestaurantList> _restaurantList;

  @override
  void initState() {
    super.initState();
    initialization();
    _restaurantList = RestaurantServices().getRestaurantList();
  }

  ///Menghapus flutter native screen
  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 2 / 1.7,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
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
                                child: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
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
                    child: GestureDetector(
                      onTap: () => context.go('/search'),
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
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey[400]),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Search...',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
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
            FutureBuilder<RestaurantList>(
              future: _restaurantList,
              builder: (context, AsyncSnapshot<RestaurantList> snapshot) {
                var state = snapshot.connectionState;
                if (state != ConnectionState.done) {
                  return const Center();
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = snapshot.data?.restaurants[index];
                          return CustomCard(restaurant: restaurant!);
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Material(
                        child: Text('Error: Data not found'),
                      ),
                    );
                  } else {
                    return const Material(child: Text(''));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
