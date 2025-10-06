import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/verify_otp_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ForgetOtpVerifyController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  OtpVerifyResponse? otpVerifyResponse;

  /// 🔹 Verify Forget OTP
  Future<void> verifyForgetOtp(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.forgetverifyotp(params: params);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data; // ✅ use .data instead of .body

        otpVerifyResponse = OtpVerifyResponse.fromJson(data);

        if (otpVerifyResponse!.success) {
          Get.snackbar(
            "Success",
            otpVerifyResponse!.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF4CAF50),
            colorText: Colors.white,
          );
        } else {
          errorMessage.value = otpVerifyResponse!.message;
          Get.snackbar(
            "Failed",
            otpVerifyResponse!.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFFF5252),
            colorText: Colors.white,
          );
        }
      } else {
        errorMessage.value = "Something went wrong: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Error verifying OTP: $e";
      print("Error verifying OTP: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
