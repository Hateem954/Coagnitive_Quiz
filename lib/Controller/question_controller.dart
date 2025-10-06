import 'package:get/get.dart';
import 'package:quiz/Model/question_model.dart';
import 'package:quiz/api_Services/repo.dart';

class QuestionController extends GetxController {
  /// Observable states
  var isLoading = false.obs;
  var questions = <Question>[].obs;
  var errorMessage = ''.obs;

  /// Fetch all questions for the given quiz/category hashid
  Future<void> fetchQuestions(String hashid) async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ApiService().getquestions(hashid);
      print('📩 GetQuestions Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data != null && data['success'] == true) {
          final quizResponse = QuizQuestionResponse.fromJson(data);
          questions.assignAll(quizResponse.questions);
        } else {
          errorMessage.value = data?['message'] ?? 'Failed to load questions.';
          questions.clear();
        }
      } else {
        errorMessage.value =
            'Error: ${response.statusCode} - ${response.statusMessage}';
      }
    } catch (e) {
      errorMessage.value = '⚠️ Failed to fetch questions: $e';
      print('❌ Exception in fetchQuestions: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Helper: Get the correct answer for a question
  String getCorrectAnswer(Question question) {
    if (question.correctAnswer != null && question.correctAnswer!.isNotEmpty) {
      return question.correctAnswer!;
    }

    // fallback from options if correct answer not in main field
    for (final option in question.options) {
      if (option.options == option.correctAnswer) {
        return option.correctAnswer;
      }
    }
    return '';
  }

  /// Helper: Reset all data
  void clearQuestions() {
    questions.clear();
    errorMessage('');
  }
}
