import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String userToken = 'userToken';

  static String get userName => 'userName';
}

class CacheHelper {
  static late SharedPreferences sharedPre;

  static Future<void> init() async {
    sharedPre = await SharedPreferences.getInstance();
  }

  static Future<void> setUserToken(String userToken) async {
    await sharedPre.setString(Constants.userToken, userToken);
    print('Token saved: $userToken');
  }

  static String getUserToken() {
    return sharedPre.getString(Constants.userToken) ?? '';
  }

  static Future<void> removeUserToken() async {
    await sharedPre.remove(Constants.userToken);
  }

  static const String userName = 'userName';

  static Future<void> setUserName(String userName) async {
    await sharedPre.setString(Constants.userName, userName);
  }

  static String getUserName() {
    return sharedPre.getString(Constants.userName) ?? '';
  }
}