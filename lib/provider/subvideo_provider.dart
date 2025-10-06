import 'package:flutter/material.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/subvideo_model.dart';
import 'package:dio/dio.dart';

class SubVideoProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  bool isLoading = false;
  List<SubVideoModel> subVideos = [];

  /// Fetch videos by hashid
  Future<void> fetchSubVideos(String hashid) async {
    isLoading = true;
    subVideos = [];
    notifyListeners();

    try {
      Response response = await apiService.getCategoriesByHashid(hashid);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = SubVideoResponse.fromJson(response.data);
        subVideos = data.videos;
      }
    } catch (e) {
      debugPrint("❌ Error fetching sub videos: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Get video by index
  SubVideoModel? getVideo(int index) {
    if (index < 0 || index >= subVideos.length) return null;
    return subVideos[index];
  }
}
