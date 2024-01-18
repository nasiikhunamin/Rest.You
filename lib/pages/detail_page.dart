import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:yourest/common/style.dart';
import 'package:yourest/data/api/api_services.dart';
import 'package:yourest/data/model/restaurant.dart';
import 'package:yourest/provider/db_provider.dart';
import 'package:yourest/provider/restaurants_provider.dart';
import 'package:yourest/common/constant.dart';
import 'package:yourest/utils/result_state.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/restaurant_detail";
  final Restaurant restaurant;

  const DetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isAddReview = false;
  final _formNameKey = GlobalKey<FormState>();
  final _formReviewKey = GlobalKey<FormState>();

  int currentId = 0;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerReview = TextEditingController();
  late RestaurantProvider _restaurantProvider;

  @override
  void initState() {
    _restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _restaurantProvider.fetchDetailRestaurant(widget.restaurant.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerReview.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.stateDetail == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.stateDetail == ResultState.hasData) {
            return detailPageScreen(context, state.detail?.restaurant);
          } else if (state.stateDetail == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.stateDetail == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }

  Widget detailPageScreen(BuildContext context, restaurantData) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: primaryColor,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.restaurant.pictUrl,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl + widget.restaurant.pictUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.restaurant.name.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.merge(textPrimary),
                  ),
                  Consumer<DatabaseProvider>(
                    builder: (context, value, child) {
                      return FutureBuilder<bool>(
                        future: value.isFavorited(widget.restaurant.id),
                        builder: (context, snapshot) {
                          var isFavorite = snapshot.data ?? false;
                          return isFavorite
                              ? IconButton(
                                  onPressed: () => value
                                      .removeFavorited(widget.restaurant.id),
                                  icon: const Icon(Icons.favorite),
                                  color: favorite,
                                )
                              : IconButton(
                                  onPressed: () =>
                                      value.addFavorite(widget.restaurant),
                                  icon: const Icon(Icons.favorite_outline),
                                  color: favorite,
                                );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: favorite,
                      ),
                      Text(
                        widget.restaurant.city,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.merge(textGrey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        unratedColor: unratedColor,
                        rating: widget.restaurant.rating,
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
                        widget.restaurant.rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.merge(textGrey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Description:",
                style: Theme.of(context).textTheme.titleLarge?.merge(textGrey),
              ),
              const SizedBox(height: 5),
              ReadMoreText(
                widget.restaurant.description,
                trimLines: 4,
                trimMode: TrimMode.Line,
                trimCollapsedText: "Show more",
                trimExpandedText: "Show less",
                lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              buildReviewCard(restaurantData!.customerReviews ?? [], context),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isAddReview,
                child: Column(
                  children: [
                    Form(
                      key: _formNameKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Name";
                          }
                          return null;
                        },
                        controller: controllerName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Nama",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formReviewKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Review";
                          }
                          return null;
                        },
                        controller: controllerReview,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Review",
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          if (_formNameKey.currentState!.validate() &&
                              _formReviewKey.currentState!.validate()) {
                            await postReview(
                                review: controllerReview.text,
                                name: controllerName.text,
                                restaurantId: widget.restaurant.id,
                                context: context);
                          }
                        },
                        child: const Text("Post Review"),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isAddReview = !isAddReview;
                    });
                  },
                  child: Text(
                    isAddReview ? "Hide Form" : "Add Review",
                    style: const TextStyle(
                      color: Color(0xff477680),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Food",
                  style:
                      Theme.of(context).textTheme.titleLarge?.merge(textGrey),
                ),
              ),
              const SizedBox(height: 15),
              buildMenuItem(restaurantData?.menus?["foods"], context,
                  const Icon(Icons.fastfood_outlined)),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  "Drinks",
                  style:
                      Theme.of(context).textTheme.titleLarge?.merge(textGrey),
                ),
              ),
              buildMenuItem(restaurantData?.menus?["drinks"], context,
                  const Icon(Icons.local_drink_outlined)),
              const SizedBox(
                height: 15,
              ),
            ]),
          ),
        ));
  }
}

Widget buildReviewCard(
  List<CustomerReview> reviews,
  BuildContext context,
) {
  return SizedBox(
    height: 160,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: reviews.isNotEmpty
                ? SizedBox(
                    height: 130,
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Card(
                        color: primaryLightColor,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                review.review,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 8),
                              Text(review.date),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No Reviews Here!"),
                  ),
          );
        },
      ),
    ),
  );
}

Widget buildMenuItem(item, BuildContext context, Widget icons) {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: item?.length ?? 0,
      itemBuilder: (context, index) {
        final beverage = item?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: beverage != null
              ? SizedBox(
                  width: 100,
                  child: Card(
                    color: primaryLightColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icons,
                          const SizedBox(height: 10),
                          Text(
                            beverage["name"] ?? "",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: Text("No Food/Drinks Here!"),
                ),
        );
      },
    ),
  );
}
