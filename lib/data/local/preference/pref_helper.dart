import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const randomRestaurantNotification = "RANDOM_RESTO";

  Future<bool> get isRandomRestoNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(randomRestaurantNotification) ?? false;
  }

  void setRandomRestoNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(randomRestaurantNotification, value);
  }
}
