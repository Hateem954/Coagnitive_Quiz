import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz/model/login_model.dart';
import 'package:quiz/utils/app_consultant.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/signup_screen.dart';
import '../api_Services/repo.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  LoginResponse? _loginResponse;

  bool get isLoading => _isLoading;
  LoginResponse? get loginResponse => _loginResponse;

  final ApiService _apiService = ApiService();

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(
        params: {"email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _loginResponse = LoginResponse.fromJson(response.data);

        // ✅ Save token globally if needed
        // AppConstant.setUserToken(_loginResponse!.token);
        Get.snackbar(
          "Success",
          "Login Sucessfully",
          colorText: AppColors.black,
          backgroundColor: AppColors.transparent,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final errorMessage =
            response.data?["message"] ?? "Unknown error occurred";
        Get.snackbar(
          "Failed",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppColors.black,
          backgroundColor: AppColors.transparent,
        );
        //   throw Exception("Login failed [${response.statusCode}]: $response.responsemes");
      }
    } on DioException catch (e) {
      throw Exception("Login error: ${e.response?.data ?? e.message}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await AppConstant.clearUserToken();
    Get.offAll(() => SignUpScreen());
  }
}
