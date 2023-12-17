import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yourest/pages/detail_page.dart';
import 'package:yourest/pages/favorite_page.dart';
import 'package:yourest/pages/main_page.dart';
import 'package:yourest/model/local_restaurant.dart';
import 'package:yourest/pages/profile_page.dart';

void main() {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'You.Rest',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/favorite': (context) => const FavoritePage(),
        '/profile': (context) => const ProfilePage(),
        '/detailPage': (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
