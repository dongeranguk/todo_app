import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  AppSharedPreference._();

  static AppSharedPreference instance = AppSharedPreference._();

  static const keyCount = "count";
  static const keyLaunchCount = "launch_count";
  static const keyLaunchCount2 = "keyLaunchCount2";
  static const keyLaunchCount3 = "keyLaunchCount3";
  static const keyLaunchCount4 = "keyLaunchCount4";
  static const keyLaunchCount5 = "keyLaunchCount5";
  static const keyLaunchCount6 = "keyLaunchCount6";

  late SharedPreferences _preferences;

  static init() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  static void setCount(int count) {
    instance._preferences.setInt(keyCount, count);
  }

  /// null 인 경우는 디폴트 값 (-1) 반환
  static int getCount() {
    return instance._preferences.getInt(keyCount) ?? -1;
  }

  static void setLaunchCount(int count) {
    instance._preferences.setInt(keyLaunchCount, count);
  }

  static int getLaunchCount() {
    return instance._preferences.getInt(keyLaunchCount) ?? -1;
  }
}
