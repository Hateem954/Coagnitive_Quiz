import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/forget_update_password.dart';

class ForgetPasswordUpdateController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var updateResponse = Rxn<UpdatePasswordResponse>();
  var errorMessage = ''.obs;

  /// 🔹 Update Password
  Future<void> updatePassword(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.forgetpasswordupdate(params: params);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          updateResponse.value = UpdatePasswordResponse.fromJson(data);
          print("✅ Password Updated: ${updateResponse.value?.message}");
        } else {
          errorMessage.value = data['message'] ?? 'Failed to update password';
          print("⚠️ API Error: ${errorMessage.value}");
        }
      } else {
        errorMessage.value = 'Server Error: ${response.statusCode}';
        print("⚠️ HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
      print("❌ Exception in updatePassword: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
