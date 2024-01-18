import 'package:flutter/material.dart';
import 'package:yourest/data/local/preference/pref_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getRandomRestoNotification();
  }

  bool _isRandomRestoNotification = false;

  bool get isRandomRestoNotification => _isRandomRestoNotification;

  void _getRandomRestoNotification() async {
    _isRandomRestoNotification =
        await preferencesHelper.isRandomRestoNotificationActive;
    notifyListeners();
  }

  void enableRandomRestoNotification(bool value) {
    preferencesHelper.setRandomRestoNotification(value);
    _getRandomRestoNotification();
  }
}
