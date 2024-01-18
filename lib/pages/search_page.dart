import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourest/provider/restaurants_provider.dart';
import 'package:yourest/utils/result_state.dart';
import 'package:yourest/widget/custom_card.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = "/restaurant_search";
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _textController,
                  onChanged: (query) {
                    Provider.of<RestaurantProvider>(context, listen: false)
                        .fetchSearchRestaurant(query);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: "Search restaurant...",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Provider.of<RestaurantProvider>(context, listen: false)
                            .fetchSearchRestaurant(_textController.text);
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
              Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.stateSearch == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.stateSearch == ResultState.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.search.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.search.restaurants[index];
                          return CustomCard(
                            restaurant: restaurant,
                          );
                        },
                      ),
                    );
                  } else if (state.stateSearch == ResultState.noData) {
                    return const Text("Item Not Found");
                  } else if (state.stateSearch == ResultState.error) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: Text(''),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
