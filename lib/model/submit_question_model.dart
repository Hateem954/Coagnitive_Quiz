// class QuizSubmitResponse {
//   final bool success;
//   final QuizData? data;
//   final String message;

//   QuizSubmitResponse({required this.success, this.data, required this.message});

//   factory QuizSubmitResponse.fromJson(Map<String, dynamic> json) {
//     return QuizSubmitResponse(
//       success: json['success'] ?? false,
//       data: json['data'] != null ? QuizData.fromJson(json['data']) : null,
//       message: json['message'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {'success': success, 'data': data?.toJson(), 'message': message};
//   }
// }

// class QuizData {
//   final int score;
//   final int totalQuestions;
//   final double percentage;
//   final String aiFeedback;
//   final String detailedAnalysis;
//   final int attemptId;
//   final String category;
//   final List<AnswerDetail> answerDetails;
//   final Summary summary;

//   QuizData({
//     required this.score,
//     required this.totalQuestions,
//     required this.percentage,
//     required this.aiFeedback,
//     required this.detailedAnalysis,
//     required this.attemptId,
//     required this.category,
//     required this.answerDetails,
//     required this.summary,
//   });

//   factory QuizData.fromJson(Map<String, dynamic> json) {
//     return QuizData(
//       score: json['score'] ?? 0,
//       totalQuestions: json['total_questions'] ?? 0,
//       percentage:
//           (json['percentage'] is int)
//               ? (json['percentage'] as int).toDouble()
//               : (json['percentage'] ?? 0.0),
//       aiFeedback: json['ai_feedback'] ?? '',
//       detailedAnalysis: json['detailed_analysis'] ?? '',
//       attemptId: json['attempt_id'] ?? 0,
//       category: json['category'] ?? '',
//       answerDetails:
//           (json['answer_details'] as List<dynamic>? ?? [])
//               .map((e) => AnswerDetail.fromJson(e))
//               .toList(),
//       summary: Summary.fromJson(json['summary'] ?? {}),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'score': score,
//       'total_questions': totalQuestions,
//       'percentage': percentage,
//       'ai_feedback': aiFeedback,
//       'detailed_analysis': detailedAnalysis,
//       'attempt_id': attemptId,
//       'category': category,
//       'answer_details': answerDetails.map((e) => e.toJson()).toList(),
//       'summary': summary.toJson(),
//     };
//   }
// }

// class AnswerDetail {
//   final String question;
//   final String userAnswer;
//   final String correctAnswer;
//   final bool isCorrect;

//   AnswerDetail({
//     required this.question,
//     required this.userAnswer,
//     required this.correctAnswer,
//     required this.isCorrect,
//   });

//   factory AnswerDetail.fromJson(Map<String, dynamic> json) {
//     return AnswerDetail(
//       question: json['question'] ?? '',
//       userAnswer: json['user_answer'] ?? '',
//       correctAnswer: json['correct_answer'] ?? '',
//       isCorrect: json['is_correct'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'question': question,
//       'user_answer': userAnswer,
//       'correct_answer': correctAnswer,
//       'is_correct': isCorrect,
//     };
//   }
// }

// class Summary {
//   final int correctAnswers;
//   final int wrongAnswers;
//   final Map<String, AnswerDetail> correctQuestions;
//   final Map<String, AnswerDetail> wrongQuestions;

//   Summary({
//     required this.correctAnswers,
//     required this.wrongAnswers,
//     required this.correctQuestions,
//     required this.wrongQuestions,
//   });

//   factory Summary.fromJson(Map<String, dynamic> json) {
//     final correctMap = <String, AnswerDetail>{};
//     final wrongMap = <String, AnswerDetail>{};

//     if (json['correct_questions'] != null) {
//       (json['correct_questions'] as Map<String, dynamic>).forEach((key, value) {
//         correctMap[key] = AnswerDetail.fromJson(value);
//       });
//     }

//     if (json['wrong_questions'] != null) {
//       (json['wrong_questions'] as Map<String, dynamic>).forEach((key, value) {
//         wrongMap[key] = AnswerDetail.fromJson(value);
//       });
//     }

//     return Summary(
//       correctAnswers: json['correct_answers'] ?? 0,
//       wrongAnswers: json['wrong_answers'] ?? 0,
//       correctQuestions: correctMap,
//       wrongQuestions: wrongMap,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'correct_answers': correctAnswers,
//       'wrong_answers': wrongAnswers,
//       'correct_questions': correctQuestions.map(
//         (k, v) => MapEntry(k, v.toJson()),
//       ),
//       'wrong_questions': wrongQuestions.map((k, v) => MapEntry(k, v.toJson())),
//     };
//   }
// }

class QuizSubmitResponse {
  final bool success;
  final QuizData? data;

  QuizSubmitResponse({required this.success, this.data});

  factory QuizSubmitResponse.fromJson(Map<String, dynamic> json) {
    return QuizSubmitResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? QuizData.fromJson(json['data']) : null,
    );
  }
}

class QuizData {
  final int? score;
  final int? totalQuestions;
  final double? percentage;
  final String? aiFeedback;
  final String? detailedAnalysis;
  final int? attemptId;
  final String? category;
  final List<AnswerDetail>? answerDetails;
  final Summary? summary;

  QuizData({
    this.score,
    this.totalQuestions,
    this.percentage,
    this.aiFeedback,
    this.detailedAnalysis,
    this.attemptId,
    this.category,
    this.answerDetails,
    this.summary,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      score: json['score'],
      totalQuestions: json['total_questions'],
      percentage:
          (json['percentage'] is int)
              ? (json['percentage'] as int).toDouble()
              : json['percentage']?.toDouble(),
      aiFeedback: json['ai_feedback'],
      detailedAnalysis: json['detailed_analysis'],
      attemptId: json['attempt_id'],
      category: json['category'],
      answerDetails:
          (json['answer_details'] as List<dynamic>?)
              ?.map((e) => AnswerDetail.fromJson(e))
              .toList(),
      summary:
          json['summary'] is Map<String, dynamic>
              ? Summary.fromJson(json['summary'])
              : null,
    );
  }
}

class AnswerDetail {
  final String? question;
  final String? userAnswer;
  final String? correctAnswer;
  final bool? isCorrect;

  AnswerDetail({
    this.question,
    this.userAnswer,
    this.correctAnswer,
    this.isCorrect,
  });

  factory AnswerDetail.fromJson(Map<String, dynamic> json) {
    return AnswerDetail(
      question: json['question'],
      userAnswer: json['user_answer'],
      correctAnswer: json['correct_answer'],
      isCorrect: json['is_correct'],
    );
  }
}

class Summary {
  final int? correctAnswers;
  final int? wrongAnswers;
  final List<QuestionResult>? correctQuestions;
  final List<QuestionResult>? wrongQuestions;

  Summary({
    this.correctAnswers,
    this.wrongAnswers,
    this.correctQuestions,
    this.wrongQuestions,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      correctAnswers: json['correct_answers'],
      wrongAnswers: json['wrong_answers'],
      correctQuestions:
          (json['correct_questions'] as List<dynamic>?)
              ?.map((e) => QuestionResult.fromJson(e))
              .toList(),
      wrongQuestions:
          (json['wrong_questions'] as List<dynamic>?)
              ?.map((e) => QuestionResult.fromJson(e))
              .toList(),
    );
  }
}

class QuestionResult {
  final String? question;
  final String? userAnswer;
  final String? correctAnswer;

  QuestionResult({this.question, this.userAnswer, this.correctAnswer});

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      question: json['question'],
      userAnswer: json['user_answer'],
      correctAnswer: json['correct_answer'],
    );
  }
}
