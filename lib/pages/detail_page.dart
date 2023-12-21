import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:yourest/model/restaurant_detail.dart';
import 'package:yourest/provider/detail_restaurant_provider.dart';
import 'package:yourest/utils/constant.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ///Selected index Button Menu
  bool _isSelectedButton = true;

  ///Get menu restaurant foods
  List<Category> getFoods(Restaurant restaurant) {
    return restaurant.menus.foods;
  }

  ///Get menu restaurant drinks
  List<Category> getDrinks(Restaurant restaurant) {
    return restaurant.menus.drinks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            Consumer<RestaurantDetailProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state.state == ResultState.hasData) {
                  return SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: const Color(0xff477680),
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: state.result.restaurant.pictureId,
                        child: CachedNetworkImage(
                          imageUrl: imgUrl + state.result.restaurant.pictureId,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Text(''),
                  );
                }
              },
            ),
          ];
        },
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.result.restaurant;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff477680)),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                              ),
                              Text(
                                restaurant.city,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                unratedColor: const Color(0xffA9A9A9),
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
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ReadMoreText(
                        restaurant.description,
                        trimLines: 4,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
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
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xfff5f3ff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Material(
                              color: _isSelectedButton
                                  ? const Color(0xff477680)
                                  : const Color(0xff477680).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isSelectedButton = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 35,
                                  ),
                                  child: const Text(
                                    "Foods",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: _isSelectedButton
                                  ? const Color(0xff477680).withOpacity(0.4)
                                  : const Color(0xff477680),
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isSelectedButton = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 35,
                                  ),
                                  child: const Text(
                                    "Drinks",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_isSelectedButton) ...[
                              for (var food in getFoods(restaurant))
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: const Color(0xff477680)
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                    title: Text(
                                      food.name,
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ListTileStyle.list,
                                  ),
                                ),
                            ] else ...[
                              for (var drink in getDrinks(restaurant))
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: const Color(0xff477680)
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                    title: Text(
                                      drink.name,
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ListTileStyle.list,
                                    visualDensity:
                                        VisualDensity.adaptivePlatformDensity,
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Error: Data not found'),
              );
            }
          },
        ),
      ),
    );
  }
}
















/*
class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

///Defaul selected button
bool _isSelectedButton = true;

class _DetailPageState extends State<DetailPage> {
  // Future<Welcome> fetchData() async {
  //   String jsonString = await DefaultAssetBundle.of(context)
  //       .loadString('assets/local_restaurant.json');
  //   return welcomeFromJson(jsonString);
  // }

  List<Category> getFoods(Restaurant restaurant) {
    return restaurant.menus.foods;
  }

  List<Category> getDrinks(Restaurant restaurant) {
    return restaurant.menus.drinks;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: const Color(0xff477680),
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: state.result.restaurant.pictureId,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl + state.result.restaurant.pictureId,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          }),
        ];
      }, body: Consumer(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff477680)),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            Text(
                              widget.restaurant.city,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              unratedColor: const Color(0xffA9A9A9),
                              rating: widget.restaurant.rating,
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
                              widget.restaurant.rating.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.restaurant.description,
                      maxLines: 4,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        "Menu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f3ff),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Material(
                            color: _isSelectedButton
                                ? const Color(0xff477680)
                                : const Color(0xff477680).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isSelectedButton = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 35,
                                ),
                                child: const Text(
                                  "Foods",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: _isSelectedButton
                                ? const Color(0xff477680).withOpacity(0.4)
                                : const Color(0xff477680),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isSelectedButton = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 35,
                                ),
                                child: const Text(
                                  "Drinks",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_isSelectedButton) ...[
                            for (var food in getFoods(widget.restaurant))
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: const Color(0xff477680)
                                          .withOpacity(0.4),
                                    ),
                                  ),
                                  visualDensity:
                                      VisualDensity.adaptivePlatformDensity,
                                  title: Text(
                                    food.name,
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ListTileStyle.list,
                                ),
                              ),
                          ] else ...[
                            for (var drink in getDrinks(widget.restaurant))
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: const Color(0xff477680)
                                          .withOpacity(0.4),
                                    ),
                                  ),
                                  title: Text(
                                    drink.name,
                                    textAlign: TextAlign.center,
                                  ),
                                  style: ListTileStyle.list,
                                  visualDensity:
                                      VisualDensity.adaptivePlatformDensity,
                                ),
                              ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      )),
    );
  }
}
 */
