import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yourest/provider/search_restaurant_provider.dart';
import 'package:yourest/widget/custom_restaurant_search.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<RestaurantSearchPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (context) => RestaurantSearchProvider(),
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 60,
                      child: TextField(
                        controller: _textController,
                        onChanged: (query) {
                          Provider.of<RestaurantSearchProvider>(context,
                                  listen: false)
                              .searchRestaurant(query);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          hintText: 'Search restaurant...',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Provider.of<RestaurantSearchProvider>(context,
                                      listen: false)
                                  .searchRestaurant(_textController.text);
                            },
                            child: const Icon(
                              Icons.search,
                              size: 20,
                            ),
                          ),
                          suffixIconColor: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        context.watch<RestaurantSearchProvider>().isLoading ==
                                true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : context
                                        .watch<RestaurantSearchProvider>()
                                        .result
                                        .founded >
                                    0
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: ListView.builder(
                                        itemCount: context
                                            .watch<RestaurantSearchProvider>()
                                            .result
                                            .founded,
                                        itemBuilder: (context, index) {
                                          var restaurant = context
                                              .watch<RestaurantSearchProvider>()
                                              .result
                                              .restaurants[index];
                                          return GestureDetector(
                                            onTap: () {
                                              context.pushNamed('detail',
                                                  pathParameters: {
                                                    "id": restaurant.id,
                                                  });
                                            },
                                            child: CustomCardRestaurant(
                                              restaurant: restaurant,
                                            ),
                                          );
                                        }),
                                  )
                                : context
                                            .watch<RestaurantSearchProvider>()
                                            .result
                                            .founded ==
                                        0
                                    ? Text(
                                        context
                                            .watch<RestaurantSearchProvider>()
                                            .message,
                                      )
                                    : const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
