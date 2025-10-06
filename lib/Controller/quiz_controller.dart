import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/quiz_model.dart';

class QuizController extends GetxController {
  final ApiService apiService = ApiService();

  // Observables
  var isLoading = false.obs;
  var quizzes = <Quiz>[].obs;
  var errorMessage = ''.obs;

  /// Fetch all quizzes
  Future<void> fetchQuizzes() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.showallquizzes({});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Parse response into QuizResponse model
        final quizResponse = QuizResponse.fromJson(data);

        if (quizResponse.success) {
          quizzes.assignAll(quizResponse.quizzes);
        } else {
          errorMessage.value = quizResponse.message;
        }
      } else {
        errorMessage.value = "Something went wrong: ${response.statusMessage}";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
