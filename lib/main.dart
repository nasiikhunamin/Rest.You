import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourest/common/style.dart';
import 'package:yourest/data/local/database/database_helper.dart';
import 'package:yourest/data/local/preference/pref_helper.dart';
import 'package:yourest/data/model/restaurant.dart';
import 'package:yourest/pages/detail_page.dart';
import 'package:yourest/pages/favorite_page.dart';
import 'package:yourest/pages/main_page.dart';
import 'package:yourest/pages/settings_page.dart';
import 'package:yourest/pages/search_page.dart';
import 'package:yourest/provider/db_provider.dart';
import 'package:yourest/provider/preference_provider.dart';
import 'package:yourest/provider/restaurants_provider.dart';
import 'package:yourest/provider/schedulling_provider.dart';
import 'package:yourest/data/api/api_services.dart';
import 'package:yourest/utils/navigation.dart';
import 'package:yourest/utils/notification_helper.dart';
import 'package:yourest/utils/backgorund_services_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    _notificationHelper.configureSelectNotificationSubject(
      DetailPage.routeName,
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "You.Rest",
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
              ),
          textTheme: textTheme,
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (context) => const MainPage(),
          DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          FavoritePage.routeName: (context) => const FavoritePage(),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
        },
      ),
    );
  }
}
