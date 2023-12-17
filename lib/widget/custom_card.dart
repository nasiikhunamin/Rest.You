import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yourest/model/local_restaurant.dart';

class CustomCard extends StatelessWidget {
  final Restaurant restaurant;
  const CustomCard({
    required this.restaurant,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/detailPage", arguments: restaurant);
        },
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 4,
              offset: const Offset(0, 3),
            ),
          ], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Hero(
                  tag: restaurant.pictureId,
                  transitionOnUserGestures: true,
                  child: CachedNetworkImage(
                    imageUrl: restaurant.pictureId,
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
                child: Text(
                  restaurant.name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff477680)),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.redAccent),
                          Text(
                            restaurant.city,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[600]),
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
                            color: Color(0xffffc207),
                          ),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            color: Color(0xff3A3E3E),
                          ),
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
