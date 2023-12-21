import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yourest/pages/detail_page.dart';
import 'package:yourest/pages/favorite_page.dart';
import 'package:yourest/pages/main_page.dart';
import 'package:yourest/pages/search_page.dart';
import 'package:yourest/provider/detail_restaurant_provider.dart';
import 'package:yourest/provider/list_restaurant_provider.dart';
import 'package:yourest/provider/search_restaurant_provider.dart';
import 'package:yourest/services/restaurant_services.dart';

void main() {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(
            restaurantServices: RestaurantServices(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'favorite',
          path: 'favorite',
          builder: (BuildContext context, GoRouterState state) {
            return const FavoritePage();
          },
        ),
        GoRoute(
          name: "/detailPage",
          path: 'detail/:id',
          builder: (context, state) {
            String id = state.pathParameters['id']!;
            return ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (_) => RestaurantDetailProvider(
                  restaurantServices: RestaurantServices(), id: id),
              child: DetailPage(id: id),
            );
          },
        ),
        GoRoute(
          name: '/search',
          path: 'search',
          builder: (context, state) {
            return ChangeNotifierProvider<RestaurantSearchProvider>(
              create: (_) => RestaurantSearchProvider(),
              child: const RestaurantSearchPage(),
            );
          },
        )
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'You.Rest',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      routerConfig: _router,
    );
  }
}
