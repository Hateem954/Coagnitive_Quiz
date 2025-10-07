class QuizSubmitResponse {
  final bool success;
  final QuizData? data;

  QuizSubmitResponse({required this.success, this.data});

  factory QuizSubmitResponse.fromJson(Map<String, dynamic> json) {
    return QuizSubmitResponse(
      success: json['success'] ?? false,
      data:
          json['data'] != null
              ? QuizData.fromJson(Map<String, dynamic>.from(json['data']))
              : null,
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
              : (json['percentage'] ?? 0.0).toDouble(),
      aiFeedback: json['ai_feedback'],
      detailedAnalysis: json['detailed_analysis'],
      attemptId: json['attempt_id'],
      category: json['category'],
      answerDetails:
          (json['answer_details'] is List)
              ? (json['answer_details'] as List)
                  .whereType<Map>()
                  .map(
                    (e) => AnswerDetail.fromJson(Map<String, dynamic>.from(e)),
                  )
                  .toList()
              : [],
      summary:
          (json['summary'] is Map)
              ? Summary.fromJson(Map<String, dynamic>.from(json['summary']))
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
      isCorrect: json['is_correct'] ?? false,
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
      correctAnswers: json['correct_answers'] ?? 0,
      wrongAnswers: json['wrong_answers'] ?? 0,
      correctQuestions: _parseQuestionList(json['correct_questions']),
      wrongQuestions: _parseQuestionList(json['wrong_questions']),
    );
  }

  /// ✅ Handles both list and map structures safely
  static List<QuestionResult> _parseQuestionList(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => QuestionResult.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else if (data is Map) {
      // Sometimes backend sends a map instead of list
      return [QuestionResult.fromJson(Map<String, dynamic>.from(data))];
    }
    return [];
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
