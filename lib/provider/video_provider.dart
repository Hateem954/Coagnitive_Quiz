// // import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';

// // class VideoProvider extends ChangeNotifier {
// //   final List videos;
// //   late VideoPlayerController controller;
// //   int selectedIndex = 0;

// //   VideoProvider(this.videos) {
// //     _loadVideo(0);
// //   }

// //   Map<String, dynamic> get currentVideo => videos[selectedIndex];

// //   void _loadVideo(int index) {
// //     controller = VideoPlayerController.network(videos[index]["url"])
// //       ..initialize().then((_) {
// //         controller.play();
// //         notifyListeners();
// //       });
// //     selectedIndex = index;
// //   }

// //   void changeVideo(int index) {
// //     controller.pause();
// //     controller.dispose();
// //     _loadVideo(index);
// //     notifyListeners();
// //   }

// //   @override
// //   void dispose() {
// //     controller.dispose();
// //     super.dispose();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:quiz/model/video_model.dart';
// import 'package:video_player/video_player.dart';

// class VideoProvider extends ChangeNotifier {
//   final List<VideoModel> videos;
//   late VideoPlayerController controller;
//   int selectedIndex = 0;

//   VideoProvider(this.videos) {
//     _loadVideo(0);
//   }

//   VideoModel get currentVideo => videos[selectedIndex];

//   void _loadVideo(int index) {
//     controller = VideoPlayerController.network(
//         "https://d8ca871017cc.ngrok-free.app/api/${videos[index].video}",
//       )
//       ..initialize().then((_) {
//         controller.play();
//         notifyListeners();
//       });
//     selectedIndex = index;
//   }

//   void changeVideo(int index) {
//     controller.pause();
//     controller.dispose();
//     _loadVideo(index);
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// import 'package:flutter/material.dart';
// import 'package:quiz/api_Services/repo.dart';
// import 'package:quiz/model/video_model.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:developer';

// class VideoProvider extends ChangeNotifier {
//   List<VideoModel> videos = []; // list of videos from API
//   VideoPlayerController? controller;
//   int selectedIndex = 0;

//   VideoProvider() {
//     fetchVideos(); // 🔹 fetch videos when provider is created
//   }

//   VideoModel? get currentVideo =>
//       videos.isNotEmpty ? videos[selectedIndex] : null;

//   /// Fetch videos from API
//   Future<void> fetchVideos() async {
//     try {
//       final response = await ApiService().getVideos({});
//       log("API Response: ${response.data}");

//       final videoResponse = VideoResponse.fromJson(response.data);

//       // ✅ collect all latest videos from categories
//       videos =
//           videoResponse.categories
//               .map((cat) => cat.latestVideo)
//               .whereType<VideoModel>()
//               .toList();

//       if (videos.isNotEmpty) {
//         _loadVideo(0);
//       }
//       notifyListeners();
//     } catch (e) {
//       log("Fetch Videos Error: $e");
//     }
//   }

//   void _loadVideo(int index) {
//     if (videos.isEmpty) return;

//     controller = VideoPlayerController.network(
//         "https://d8ca871017cc.ngrok-free.app/${videos[index].video}",
//       )
//       ..initialize().then((_) {
//         controller!.play();
//         notifyListeners();
//       });

//     selectedIndex = index;
//   }

//   void changeVideo(int index) {
//     if (index < 0 || index >= videos.length) return;

//     controller?.pause();
//     controller?.dispose();
//     _loadVideo(index);
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

//***************************************************************************************************************************** */
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:quiz/api_Services/repo.dart';
// import 'package:quiz/model/video_model.dart';
// import 'package:video_player/video_player.dart';

// class VideoProvider extends ChangeNotifier {
//   List<VideoModel> videos = []; // list of videos from API
//   VideoPlayerController? controller;
//   int selectedIndex = 0;

//   bool isLoading = false; // ✅ added
//   String? errorMessage; // ✅ added

//   VideoProvider() {
//     fetchVideos(); // 🔹 fetch videos when provider is created
//   }

//   VideoModel? get currentVideo =>
//       videos.isNotEmpty ? videos[selectedIndex] : null;

//   /// Fetch videos from API
//   Future<void> fetchVideos() async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       final response = await ApiService().getVideos({});
//       log("API Response: ${response.data}");

//       final videoResponse = VideoResponse.fromJson(response.data);

//       // ✅ collect all latest videos from categories
//       videos =
//           videoResponse.categories
//               .map((cat) => cat.latestVideo)
//               .whereType<VideoModel>()
//               .toList();

//       if (videos.isNotEmpty) {
//         _loadVideo(0);
//       } else {
//         errorMessage = "No videos available.";
//       }
//     } catch (e) {
//       log("Fetch Videos Error: $e");
//       errorMessage = "Failed to load videos.";
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   void _loadVideo(int index) {
//     if (videos.isEmpty) return;

//     controller = VideoPlayerController.network(
//         "https://d8ca871017cc.ngrok-free.app/${videos[index].video}",
//       )
//       ..initialize()
//           .then((_) {
//             controller!.play();
//             notifyListeners();
//           })
//           .catchError((e) {
//             errorMessage = "Video not available.";
//             notifyListeners();
//           });

//     selectedIndex = index;
//   }

//   void changeVideo(int index) {
//     if (index < 0 || index >= videos.length) return;

//     controller?.pause();
//     controller?.dispose();
//     _loadVideo(index);
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  List<CategoryWithVideo> categories = []; // ✅ store categories from API
  List<VideoModel> videos = []; // ✅ still keep flat list for playback
  VideoPlayerController? controller;
  int selectedIndex = 0;

  bool isLoading = false;
  String? errorMessage;

  VideoProvider() {
    fetchVideos();
  }

  VideoModel? get currentVideo =>
      videos.isNotEmpty ? videos[selectedIndex] : null;

  /// Fetch videos + categories from API
  Future<void> fetchVideos() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService().getVideos({});
      log("API Response: ${response.data}");

      final videoResponse = VideoResponse.fromJson(response.data);

      // ✅ Save categories
      categories = videoResponse.categories;

      // ✅ Flatten latest videos for playback
      videos =
          categories
              .map((cat) => cat.latestVideo)
              .whereType<VideoModel>()
              .toList();

      if (videos.isNotEmpty) {
        _loadVideo(0);
      } else {
        errorMessage = "No videos available.";
      }
    } catch (e) {
      log("Fetch Videos Error: $e");
      errorMessage = "Failed to load videos.";
    }

    isLoading = false;
    notifyListeners();
  }

  void _loadVideo(int index) {
    if (videos.isEmpty) return;

    controller = VideoPlayerController.network(
        "${AppUrl.imageBaseUrl}${videos[index].video}",
      )
      ..initialize()
          .then((_) {
            controller!.play();
            notifyListeners();
          })
          .catchError((e) {
            errorMessage = "Video not available.";
            notifyListeners();
          });

    selectedIndex = index;
  }

  void changeVideo(int index) {
    if (index < 0 || index >= videos.length) return;

    controller?.pause();
    controller?.dispose();
    _loadVideo(index);
    notifyListeners();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
