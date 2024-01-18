import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:yourest/common/style.dart';
import 'package:yourest/pages/search_page.dart';
import 'package:yourest/provider/restaurants_provider.dart';
import 'package:yourest/utils/result_state.dart';
import 'package:yourest/widget/custom_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = "restaurant_home";
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initialization();
  }

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
                    color: primaryColor,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/logo_splash.png"),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Welcome, Rest",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.merge(textWhite),
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
                          Text(
                            "Find best restaurant around you.",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.merge(textWhite),
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
                      onTap: () => Navigator.pushNamed(
                          context, RestaurantSearchPage.routeName),
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
                                "Search...",
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
            SizedBox(
              height: 120,
              child: OverflowBox(
                minHeight: 200,
                maxHeight: 200,
                child: Lottie.asset(
                  "assets/welcome_animation.json",
                ),
              ),
            ),
            Consumer<RestaurantProvider>(
              builder: (context, value, child) {
                if (value.stateList == ResultState.loading) {
                  return const Center(
                    child: Text(''),
                  );
                } else if (value.stateList == ResultState.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = value.result.restaurants[index];
                        return CustomCard(
                          restaurant: restaurant,
                        );
                      },
                    ),
                  );
                } else if (value.stateList == ResultState.noData) {
                  return Center(
                    child: Text(value.message),
                  );
                } else if (value.stateList == ResultState.error) {
                  return Center(
                    child: Text(value.message.toString()),
                  );
                } else {
                  return const Center(
                    child: Text(""),
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
