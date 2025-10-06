import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/profile_mode.dart';

class ProfileProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  Profile? _profile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Profile? get profile => _profile;

  /// Fetch Profile API
  Future<void> fetchProfile({Map<String, dynamic>? params}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Response response = await _apiService.getprofile(params);

      if (response.statusCode == 200) {
        final data = response.data;

        // If API directly returns profile JSON
        _profile = Profile.fromJson(data);

        // If API wraps response like {"success":true,"profile":{...}}
        // _profile = Profile.fromJson(data["profile"]);

        debugPrint("✅ Profile fetched successfully");
      } else {
        _errorMessage = "Failed to load profile: ${response.statusCode}";
        debugPrint("⚠️ $_errorMessage");
      }
    } catch (e) {
      _errorMessage = "Error fetching profile: $e";
      debugPrint("❌ $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh profile manually
  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  /// Clear profile data (e.g., on logout)
  void clearProfile() {
    _profile = null;
    notifyListeners();
  }
}
