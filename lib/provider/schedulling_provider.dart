import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:yourest/utils/backgorund_services_notifications.dart';
import 'package:yourest/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> setScheduling(bool value) async {
    _isScheduled = value;
    notifyListeners();

    if (_isScheduled) {
      if (kDebugMode) {
        print("Scheduling Restaurant Active");
      }
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print("Scheduling Restaurant Stoped");
      }
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
