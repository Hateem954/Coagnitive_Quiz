// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppConstant {
//   static String saveUserToken = 'saveUserToken';
//   static String saveUserRefresh = 'saveUserRefresh';
//   static String saveUserID = 'saveUserID';
//   static String saveUserEmail = 'saveUserEmail';
//   static String saveUserPassword = 'saveUserPassword';
//   static String userFcmToken = '';
//   static String getUserToken = '';
//   static String getUserRefresh = '';
//   static String getUserID = '';
//   static String getUserEmail = '';
//   static String getUserPassword = '';

//   /// Check if user is already logged in
//   static Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString(saveUserToken);
//     final email = prefs.getString(saveUserEmail);
//     final password = prefs.getString(saveUserPassword);

//     if (token != null && email != null && password != null) {
//       getUserToken = token;
//       getUserEmail = email;
//       getUserPassword = password;
//       return true;
//     }
//     return false;
//   }

//   /// Save user credentials
//   static Future<void> saveUserCredentials({
//     required String Authorization,
//     required String email,
//     required String password,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(saveUserToken, Authorization);
//     await prefs.setString(saveUserEmail, email);
//     await prefs.setString(saveUserPassword, password);

//     getUserToken = Authorization;
//     getUserEmail = email;
//     getUserPassword = password;

//     print('token after login.....$getUserToken');
//   }

//   /// Clear user data from SharedPreferences
//   static Future<void> clearUserToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(saveUserToken);
//     await prefs.remove(saveUserRefresh);
//     await prefs.remove(saveUserID);
//     await prefs.remove(saveUserEmail);
//     await prefs.remove(saveUserPassword);

//     getUserToken = ''; // Reset to provided token
//     getUserEmail = '';
//     getUserPassword = '';
//   }

//   // static String validatePrice({
//   //   double? price,
//   //   required String currencyCode,
//   //   required BuildContext context,
//   // }) {
//   //   String priceSymbol = currencyCode.trim();

//   //   print('currency code....: $currencyCode');

//   //   if (price == null || price < 0) {
//   //     switch (priceSymbol) {
//   //       case '\$':
//   //         return "0.0 $priceSymbol";
//   //       case 'Fr':
//   //         return "$priceSymbol 0.0";
//   //       case '€':
//   //         return "$priceSymbol 0.0";
//   //       default:
//   //         return "$priceSymbol 0.0";
//   //     }
//   //   } else {
//   //     switch (priceSymbol) {
//   //       case '\$':
//   //         return "${price.toStringAsFixed(2)} $priceSymbol";
//   //       case 'Fr':
//   //         return "$priceSymbol ${price.toStringAsFixed(2)}";
//   //       case '€':
//   //         return "$priceSymbol ${price.toStringAsFixed(2)}";
//   //       default:
//   //         return "$priceSymbol ${price.toStringAsFixed(2)}";
//   //     }
//   //   }
//   // }
// }

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstant {
  // Keys for SharedPreferences
  static String saveUserToken = 'saveUserToken';
  static String saveUserRefresh = 'saveUserRefresh';
  static String saveUserID = 'saveUserID';
  static String saveUserEmail = 'saveUserEmail';
  static String saveUserPassword = 'saveUserPassword';
  static String saveUserAPIKey = 'saveUserAPIKey'; // ✅ Added for API key

  // Runtime variables
  static String userFcmToken = '';
  static String getUserToken = '';
  static String getUserRefresh = '';
  static String getUserID = '';
  static String getUserEmail = '';
  static String getUserPassword = '';
  static String getUserAPIKey = ''; // ✅ Store API key here

  /// Check if user is already logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(saveUserToken);
    final email = prefs.getString(saveUserEmail);
    final password = prefs.getString(saveUserPassword);
    final apiKey = prefs.getString(saveUserAPIKey);

    if (token != null && email != null && password != null && apiKey != null) {
      getUserToken = token;
      getUserEmail = email;
      getUserPassword = password;
      getUserAPIKey = apiKey;
      return true;
    }
    return false;
  }

  /// Save user credentials (Token + API Key + Email + Password)
  static Future<void> saveUserCredentials({
    required String Authorization,
    required String apiKey,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(saveUserToken, Authorization);
    await prefs.setString(saveUserAPIKey, apiKey);
    await prefs.setString(saveUserEmail, email);
    await prefs.setString(saveUserPassword, password);

    getUserToken = Authorization;
    getUserAPIKey = apiKey;
    getUserEmail = email;
    getUserPassword = password;

    debugPrint('Token after login: $getUserToken');
    debugPrint('API Key after login: $getUserAPIKey');
  }

  /// Load user credentials
  static Future<void> loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    getUserToken = prefs.getString(saveUserToken) ?? '';
    getUserAPIKey = prefs.getString(saveUserAPIKey) ?? '';
    getUserEmail = prefs.getString(saveUserEmail) ?? '';
    getUserPassword = prefs.getString(saveUserPassword) ?? '';

    debugPrint('Loaded Token: $getUserToken');
    debugPrint('Loaded API Key: $getUserAPIKey');
  }

  /// Clear user data from SharedPreferences
  /// Clear user data from SharedPreferences
  static Future<void> clearUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(saveUserToken);
    await prefs.remove(saveUserRefresh);
    await prefs.remove(saveUserID);
    await prefs.remove(saveUserEmail);
    await prefs.remove(saveUserPassword);
    await prefs.remove(saveUserAPIKey);

    // ✅ Clear runtime variables as well
    getUserToken = '';
    getUserAPIKey = '';
    getUserEmail = '';
    getUserPassword = '';

    debugPrint('✅ User token and data cleared from local storage.');
  }
}
