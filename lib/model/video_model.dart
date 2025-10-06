// class VideoResponse {
//   final bool success;
//   final String message;
//   final List<VideoModel> videos;

//   VideoResponse({
//     required this.success,
//     required this.message,
//     required this.videos,
//   });

//   factory VideoResponse.fromJson(Map<String, dynamic> json) {
//     return VideoResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? "",
//       videos:
//           (json['vedio'] as List<dynamic>?)
//               ?.map((e) => VideoModel.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }

// class VideoModel {
//   final int id;
//   final int quizCategoryId;
//   final String title;
//   final String video;
//   final String description;
//   final String vedioImage;
//   final String createdAt;
//   final String updatedAt;
//   final List<QuizCategory> quizCategory;

//   VideoModel({
//     required this.id,
//     required this.quizCategoryId,
//     required this.title,
//     required this.video,
//     required this.description,
//     required this.vedioImage,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.quizCategory,
//   });

//   factory VideoModel.fromJson(Map<String, dynamic> json) {
//     return VideoModel(
//       id: json['id'] ?? 0,
//       quizCategoryId: json['quiz_category_id'] ?? 0,
//       title: json['title'] ?? "",
//       video: json['video'] ?? "",
//       description: json['description'] ?? "",
//       vedioImage: json['vedio_image'] ?? "",
//       createdAt: json['created_at'] ?? "",
//       updatedAt: json['updated_at'] ?? "",
//       quizCategory:
//           (json['quiz_category'] as List<dynamic>?)
//               ?.map((e) => QuizCategory.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }

// class QuizCategory {
//   final int id;
//   final String name;
//   final String description;
//   final int status;
//   final String createdAt;
//   final String updatedAt;
//   final String hashid;

//   QuizCategory({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.hashid,
//   });

//   factory QuizCategory.fromJson(Map<String, dynamic> json) {
//     return QuizCategory(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? "",
//       description: json['description'] ?? "",
//       status: json['status'] ?? 0,
//       createdAt: json['created_at'] ?? "",
//       updatedAt: json['updated_at'] ?? "",
//       hashid: json['hashid'] ?? "",
//     );
//   }
// }

class VideoResponse {
  final bool success;
  final String message;
  final List<CategoryWithVideo> categories;

  VideoResponse({
    required this.success,
    required this.message,
    required this.categories,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      categories:
          (json['categories'] as List<dynamic>? ?? [])
              .map((e) => CategoryWithVideo.fromJson(e))
              .toList(),
    );
  }
}

/// Category + latest video + video count
class CategoryWithVideo {
  final QuizCategory category;
  final int videosCount;
  final VideoModel? latestVideo;

  CategoryWithVideo({
    required this.category,
    required this.videosCount,
    required this.latestVideo,
  });

  factory CategoryWithVideo.fromJson(Map<String, dynamic> json) {
    return CategoryWithVideo(
      category: QuizCategory.fromJson(json['category'] ?? {}),
      videosCount: json['videos_count'] ?? 0,
      latestVideo:
          json['latest_video'] != null
              ? VideoModel.fromJson(json['latest_video'])
              : null,
    );
  }
}

class VideoModel {
  final int id;
  final String title;
  final String video;
  final String description;
  final String vedioImage;
  final String createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.video,
    required this.description,
    required this.vedioImage,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      video: json['video'] ?? "",
      description: json['description'] ?? "",
      vedioImage: json['vedio_image'] ?? "",
      createdAt: json['created_at'] ?? "",
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
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      hashid: json['hashid'] ?? "",
    );
  }
}
