import 'package:shared_preferences/shared_preferences.dart';

class HelpersFunctions{

  static String sharedPreferenceUserLoggedInKey = "userILogin";
  static String sharedPreferenceAdmainIsLoggedIn = "adminIsLoginIn";
  static String sharedPreferenceUserRegisterIdKey = "RegisterId";
  static String sharedPreferenceUserNameKey = "userNameKey";
  static String sharedPreferenceUserEmailKey = "userEmailKey";



  /// saving data to shared preference

  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveAdmainIsLoggedIn(bool isAdmainLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceAdmainIsLoggedIn, isAdmainLoggedIn);
  }

  static Future<bool> saveResultIdInSharedPreference(String resultId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserRegisterIdKey , resultId);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey , userName);
  }
  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }



  /// fetching data from shared preference

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<bool> getAdmainIsLoggedIn() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getBool(sharedPreferenceAdmainIsLoggedIn);
  }

  static Future<String> getResultIdInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharedPreferenceUserRegisterIdKey);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserEmailKey);
  }

}