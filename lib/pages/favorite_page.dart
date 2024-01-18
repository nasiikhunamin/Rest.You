import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourest/common/style.dart';
import 'package:yourest/data/model/restaurant.dart';
import 'package:yourest/provider/db_provider.dart';
import 'package:yourest/utils/result_state.dart';
import 'package:yourest/widget/custom_card.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/restaurant_favorite";
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Favorite",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, value, child) {
          if (value.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.state == ResultState.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: value.favorites.length,
                itemBuilder: (context, index) {
                  return _buildCustomFavorite(context, value.favorites[index]);
                },
              ),
            );
          } else if (value.state == ResultState.noData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/favorite404.png",
                    height: 300,
                  ),
                  Text(
                    value.message,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            );
          } else if (value.state == ResultState.error) {
            return Center(
              child: Text(value.message),
            );
          } else {
            return Center(
              child: Text(value.message),
            );
          }
        },
      ),
    );
  }
}

Widget _buildCustomFavorite(BuildContext context, Restaurant restaurant) {
  return Dismissible(
    key: Key(restaurant.id),
    onDismissed: (direction) {
      Provider.of<DatabaseProvider>(context, listen: false)
          .removeFavorited(restaurant.id);
    },
    background: Container(
      color: primaryColor,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    child: CustomCard(restaurant: restaurant),
  );
}
