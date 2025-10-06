// // import 'package:dio/dio.dart';
// // import 'package:get/get.dart';
// // import 'package:quiz/api_Services/repo.dart';
// // import 'package:quiz/model/category_model.dart';

// // class CategoryController extends GetxController {
// //   var categories = <CategoryModel>[].obs;
// //   var isLoading = false.obs;

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchCategories();
// //   }

// //   Future<void> fetchCategories() async {
// //     try {
// //       isLoading(true);
// //       final response = await ApiService().getCategories();

// //       print("📩 API Response Status: ${response.statusCode}");
// //       print("📩 API Response Data: ${response.data}");

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final data = response.data;

// //         if (data['success'] == true && data['category'] != null) {
// //           categories.value =
// //               (data['category'] as List)
// //                   .map((e) => CategoryModel.fromJson(e))
// //                   .toList();

// //           print("✅ Categories Loaded: ${categories.length}");
// //         } else {
// //           print("⚠️ API returned success=false or no category key");
// //         }
// //       } else {
// //         print("❌ API Error: Status Code ${response.statusCode}");
// //       }
// //     } on DioException catch (dioError) {
// //       print("❌ DioException: ${dioError.message}");
// //       if (dioError.response != null) {
// //         print("❌ Dio Response Data: ${dioError.response?.data}");
// //         print("❌ Dio Response Status: ${dioError.response?.statusCode}");
// //       }
// //     } catch (e) {
// //       print("❌ General Error fetching categories: $e");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }

// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:quiz/api_Services/repo.dart';
// import 'package:quiz/model/category_model.dart';

// class CategoryController extends GetxController {
//   var quizzes = <QuizModel>[].obs; // ✅ change from categories to quizzes
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     try {
//       isLoading(true);
//       final response = await ApiService().getCategories();

//       print("📩 API Response Status: ${response.statusCode}");
//       print("📩 API Response Data: ${response.data}");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = response.data;

//         if (data['success'] == true && data['quizes'] != null) {
//           quizzes.value =
//               (data['quizes'] as List)
//                   .map((e) => QuizModel.fromJson(e))
//                   .toList();

//           print("✅ Quizzes Loaded: ${quizzes.length}");
//         } else {
//           print("⚠️ API returned success=false or no quizes key");
//         }
//       } else {
//         print("❌ API Error: Status Code ${response.statusCode}");
//       }
//     } on DioException catch (dioError) {
//       print("❌ DioException: ${dioError.message}");
//       if (dioError.response != null) {
//         print("❌ Dio Response Data: ${dioError.response?.data}");
//         print("❌ Dio Response Status: ${dioError.response?.statusCode}");
//       }
//     } catch (e) {
//       print("❌ General Error fetching categories: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/category_model.dart';

class CategoryController extends GetxController {
  var quizzes = <QuizModel>[].obs; // keep it as a list for UI
  var isLoading = false.obs;
  var count = 0.obs; // ✅ store count

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final response = await ApiService().getCategories();

      print("📩 API Response Status: ${response.statusCode}");
      print("📩 API Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true && data['quiz'] != null) {
          quizzes.value = [QuizModel.fromJson(data['quiz'])];
          count.value = data['count'] ?? 0; // ✅ store API count
          print("✅ Quizzes Loaded: ${quizzes.length}, Count: ${count.value}");
        } else {
          print("⚠️ API returned success=false or no quiz key");
        }
      } else {
        print("❌ API Error: Status Code ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      print("❌ DioException: ${dioError.message}");
      if (dioError.response != null) {
        print("❌ Dio Response Data: ${dioError.response?.data}");
        print("❌ Dio Response Status: ${dioError.response?.statusCode}");
      }
    } catch (e) {
      print("❌ General Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }
}
