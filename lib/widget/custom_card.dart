import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:yourest/common/style.dart';
import 'package:yourest/data/model/restaurant.dart';
import 'package:yourest/pages/detail_page.dart';
import 'package:yourest/provider/db_provider.dart';
import 'package:yourest/common/constant.dart';

class CustomCard extends StatelessWidget {
  final Restaurant restaurant;
  const CustomCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: restaurant);
        },
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Hero(
                  tag: restaurant.pictUrl,
                  transitionOnUserGestures: true,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl + restaurant.pictUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.merge(textPrimary),
                    ),
                    Consumer<DatabaseProvider>(
                      builder: (context, value, child) {
                        return FutureBuilder<bool>(
                          future: value.isFavorited(restaurant.id),
                          builder: (context, snapshot) {
                            var isFavorite = snapshot.data ?? false;
                            return isFavorite
                                ? IconButton(
                                    onPressed: () =>
                                        value.removeFavorited(restaurant.id),
                                    icon: const Icon(Icons.favorite),
                                    color: favorite,
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        value.addFavorite(restaurant),
                                    icon: const Icon(Icons.favorite_outline),
                                    color: favorite,
                                  );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: favorite,
                          ),
                          Text(
                            restaurant.city,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.merge(textGrey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: restaurant.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: ratingColor,
                          ),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.merge(textGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
