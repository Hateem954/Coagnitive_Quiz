import 'dart:convert';
import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/perform_quiz_model.dart';

class QuizResultController extends GetxController {
  final ApiService apiService = ApiService();

  // Observables
  var isLoading = false.obs;
  var quizResults = <QuizResult>[].obs;
  var errorMessage = ''.obs;

  /// 🔹 Fetch quiz performance results from API
  Future<void> fetchQuizResults() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await apiService.showperformquiz({});

      print("=== 📡 Raw Response ===");
      print("URL: ${response.requestOptions.uri}");
      print("Status: ${response.statusCode}");
      print("Data Type: ${response.data.runtimeType}");
      print("Response Data: ${response.data}");

      dynamic rawData = response.data;

      if (response.statusCode == 200) {
        // ✅ CASE 1: Already decoded list
        if (rawData is List) {
          quizResults.value = QuizResult.fromJsonList(
            rawData.map((e) => Map<String, dynamic>.from(e)).toList(),
          );
        }
        // ✅ CASE 2: JSON string (but not properly formatted)
        else if (rawData is String) {
          try {
            // Try decoding directly
            final decoded = json.decode(rawData);
            if (decoded is List) {
              quizResults.value = QuizResult.fromJsonList(
                decoded.map((e) => Map<String, dynamic>.from(e)).toList(),
              );
            } else {
              throw const FormatException("Not a list");
            }
          } catch (_) {
            // Try to repair malformed JSON like {id: 9, user_id: ...}
            final fixed = rawData
                .replaceAll(RegExp(r'([{,])(\s*)([a-zA-Z0-9_]+):'), r'\1"\3":')
                .replaceAll("'", '"');
            final decoded = json.decode(fixed);
            quizResults.value = QuizResult.fromJsonList(
              decoded.map((e) => Map<String, dynamic>.from(e)).toList(),
            );
          }
        }
        // ✅ CASE 3: Map with 'data' key
        else if (rawData is Map &&
            (rawData['data'] is List || rawData['results'] is List)) {
          final listData =
              (rawData['data'] ?? rawData['results']) as List<dynamic>;
          quizResults.value = QuizResult.fromJsonList(
            listData.map((e) => Map<String, dynamic>.from(e)).toList(),
          );
        } else {
          errorMessage.value = "Unexpected response format";
        }
      } else {
        errorMessage.value = "Failed to load results: ${response.statusCode}";
      }

      print("✅ Parsed ${quizResults.length} quiz results successfully");
    } catch (e) {
      errorMessage.value = "Error fetching results: $e";
      print("❌ Fetch quiz results error: $e");
    } finally {
      isLoading(false);
    }
  }
}
