// 📌 sub_video_response.dart
class SubVideoResponse {
  final bool success;
  final String message;
  final int videosCount;
  final List<SubVideoModel> videos;

  SubVideoResponse({
    required this.success,
    required this.message,
    required this.videosCount,
    required this.videos,
  });

  factory SubVideoResponse.fromJson(Map<String, dynamic> json) {
    return SubVideoResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      videosCount: json['videos_count'] ?? 0,
      videos:
          (json['videos'] as List<dynamic>?)
              ?.map((e) => SubVideoModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SubVideoModel {
  final int id;
  final int quizCategoryId;
  final String title;
  final String video;
  final String description;
  final String? vedioImage;
  final String createdAt;
  final String updatedAt;
  final List<QuizCategory> quizCategory;

  SubVideoModel({
    required this.id,
    required this.quizCategoryId,
    required this.title,
    required this.video,
    required this.description,
    this.vedioImage,
    required this.createdAt,
    required this.updatedAt,
    required this.quizCategory,
  });

  factory SubVideoModel.fromJson(Map<String, dynamic> json) {
    return SubVideoModel(
      id: json['id'] ?? 0,
      quizCategoryId: json['quiz_category_id'] ?? 0,
      title: json['title'] ?? '',
      video: json['video'] ?? '',
      description: json['description'] ?? '',
      vedioImage: json['vedio_image'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      quizCategory:
          (json['quiz_category'] as List<dynamic>?)
              ?.map((e) => QuizCategory.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class QuizCategory {
  final int id;
  final String name;
  final String description;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String hashid;

  QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.hashid,
  });

  factory QuizCategory.fromJson(Map<String, dynamic> json) {
    return QuizCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      hashid: json['hashid'] ?? '',
    );
  }
}
