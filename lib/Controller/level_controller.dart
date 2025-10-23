// import 'package:get/get.dart';
// import 'package:quiz/api_Services/repo.dart';
// import 'package:quiz/model/level_model.dart';

// class LevelController extends GetxController {
//   final ApiService apiService = ApiService();

//   /// Observable variables
//   var isLoading = false.obs;
//   var levels = <LevelModel>[].obs;

//   /// Fetch levels from API
//   Future<void> fetchLevels() async {
//     try {
//       isLoading.value = true;

//       // ✅ Call your API method
//       final response = await apiService.showlevel({});

//       if (response.statusCode == 200) {
//         final data = response.data;

//         if (data is List) {
//           // ✅ Parse the list
//           levels.value = data.map((item) => LevelModel.fromJson(item)).toList();
//         } else {
//           print('Unexpected data format: $data');
//         }
//       } else {
//         print('Error: ${response.statusCode} - ${response.statusMessage}');
//       }
//     } catch (e) {
//       print('Error fetching levels: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/level_model.dart';
import 'package:quiz/utils/colors.dart';

class LevelController extends GetxController {
  final ApiService apiService = ApiService();

  /// Observable variables
  var isLoading = false.obs;
  var levels = <LevelModel>[].obs;
  var isPosting = false.obs;
  var selectedLevel = ''.obs; // ✅ added missing variable

  /// ✅ Fetch levels from API
  Future<void> fetchLevels() async {
    try {
      isLoading.value = true;

      final response = await apiService.showlevel({});

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          levels.value = data.map((item) => LevelModel.fromJson(item)).toList();
        } else {
          print('Unexpected data format: $data');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching levels: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Post (Save) Selected Level to API
  Future<void> addLevel(String level) async {
    try {
      isPosting.value = true;

      final response = await apiService.addlevel(level: level);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final message = data['message'] ?? 'Level updated successfully';

        Get.snackbar(
          "Success",
          message,
          backgroundColor: AppColors.transparent,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
        );

        print("✅ Level Updated: $data");
      } else {
        print("❌ Failed: ${response.statusMessage}");
        Get.snackbar(
          "Error",
          "Failed to update level. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('❌ Error updating level: $e');
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isPosting.value = false;
    }
  }
}
