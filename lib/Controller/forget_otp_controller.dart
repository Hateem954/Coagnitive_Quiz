import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/forget_model.dart';

class ForgetOtpController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var otpResponse = Rxn<OtpResponse>();
  var errorMessage = ''.obs;

  /// 🔹 Send Forget Password OTP
  Future<void> sendForgetOtp(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.forgetotp(params: params);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          otpResponse.value = OtpResponse.fromJson(data);
          print("✅ OTP Sent Successfully: ${otpResponse.value?.otp}");
        } else {
          errorMessage.value = data['message'] ?? 'Failed to send OTP';
          print("⚠️ API Error: ${errorMessage.value}");
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
        print("⚠️ HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
      print("❌ Exception in sendForgetOtp: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
