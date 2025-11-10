// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:quiz/api_Services/app_url.dart';
// import 'package:quiz/model/subvideo_model.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:video_player/video_player.dart';

// class VideoDetailsScreen extends StatefulWidget {
//   final String title;
//   final String description;
//   final SubVideoModel video;

//   const VideoDetailsScreen({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.video,
//   });

//   @override
//   State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
// }

// class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
//   VideoPlayerController? _controller;
//   bool _isInitialized = false;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }

//   void _initializeVideo() async {
//     final videoPath = widget.video.video;

//     if (videoPath == null || !videoPath.endsWith('.mp4')) {
//       print("❌ Invalid or missing video file: $videoPath");
//       setState(() => _isLoading = false);
//       return;
//     }

//     final videoUrl =
//         videoPath.startsWith('http')
//             ? videoPath
//             : "${AppUrl.imageBaseUrl}${videoPath.startsWith('/') ? '' : '/'}$videoPath";

//     try {
//       _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//       await _controller!.initialize();
//       _controller!.setLooping(true);

//       setState(() {
//         _isInitialized = true;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("❌ Video initialization failed: $e");
//       setState(() => _isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to load video from: $videoUrl")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.dispose();
//   }

//   void _goFullScreen() async {
//     if (_controller == null || !_controller!.value.isInitialized) return;

//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPlayer(controller: _controller!),
//       ),
//     );

//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     final image = widget.video.vedioImage;
//     final imageUrl =
//         (image != null && image.isNotEmpty)
//             ? (image.startsWith('http')
//                 ? image
//                 : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image")
//             : null;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade300,
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: screenHeight * 0.07, left: 20),
//             child: const Text(
//               "Video Trainings",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF111133),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.85,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.06,
//                   vertical: screenHeight * 0.03,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: SizedBox(
//                         height: 200,
//                         width: double.infinity,
//                         child:
//                             _isLoading
//                                 ? const Center(
//                                   child: CircularProgressIndicator(),
//                                 )
//                                 : _isInitialized && _controller != null
//                                 ? Stack(
//                                   alignment: Alignment.bottomCenter,
//                                   children: [
//                                     AspectRatio(
//                                       aspectRatio:
//                                           _controller!.value.aspectRatio,
//                                       child: VideoPlayer(_controller!),
//                                     ),
//                                     VideoProgressIndicator(
//                                       _controller!,
//                                       allowScrubbing: true,
//                                     ),
//                                     Center(
//                                       child: IconButton(
//                                         icon: Icon(
//                                           _controller!.value.isPlaying
//                                               ? Icons.pause_circle
//                                               : Icons.play_circle,
//                                           size: 60,
//                                           color: AppColors.grey,
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             _controller!.value.isPlaying
//                                                 ? _controller!.pause()
//                                                 : _controller!.play();
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: 160,
//                                       right: 33,
//                                       child: IconButton(
//                                         icon: const Icon(
//                                           Icons.download_outlined,
//                                           color: Colors.black,
//                                           size: 22,
//                                         ),
//                                         onPressed: () {},
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: 160,
//                                       right: 3,
//                                       child: IconButton(
//                                         icon: const Icon(
//                                           Icons.crop_free,
//                                           color: Colors.black,
//                                           size: 20,
//                                         ),
//                                         onPressed: _goFullScreen,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                                 : (imageUrl != null
//                                     ? Image.network(imageUrl, fit: BoxFit.cover)
//                                     : Container(
//                                       color: Colors.grey.shade300,
//                                       child: const Icon(
//                                         Icons.image_not_supported,
//                                       ),
//                                     )),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 widget.title,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 "Intro to life",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Description:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       widget.description,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 🔹 FULLSCREEN VIDEO PLAYER WITH DOUBLE-TAP + CENTER PLAY BUTTON
// class FullScreenVideoPlayer extends StatefulWidget {
//   final VideoPlayerController controller;

//   const FullScreenVideoPlayer({super.key, required this.controller});

//   @override
//   State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
// }

// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   bool _showControls = true;

//   void _toggleControls() {
//     setState(() => _showControls = !_showControls);
//   }

//   void _seekForward() {
//     final current = widget.controller.value.position;
//     final duration = widget.controller.value.duration;
//     final target = current + const Duration(seconds: 10);
//     widget.controller.seekTo(target < duration ? target : duration);
//   }

//   void _seekBackward() {
//     final current = widget.controller.value.position;
//     final target = current - const Duration(seconds: 10);
//     widget.controller.seekTo(target > Duration.zero ? target : Duration.zero);
//   }

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: _toggleControls,
//         onDoubleTapDown: (details) {
//           final width = MediaQuery.of(context).size.width;
//           if (details.localPosition.dx < width / 2) {
//             _seekBackward();
//           } else {
//             _seekForward();
//           }
//         },
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Center(
//               child: AspectRatio(
//                 aspectRatio: widget.controller.value.aspectRatio,
//                 child: VideoPlayer(widget.controller),
//               ),
//             ),

//             // 🎯 Center Play/Pause Button
//             if (_showControls)
//               Center(
//                 child: IconButton(
//                   icon: Icon(
//                     widget.controller.value.isPlaying
//                         ? Icons.pause_circle
//                         : Icons.play_circle,
//                     color: Colors.white,
//                     size: 80,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       widget.controller.value.isPlaying
//                           ? widget.controller.pause()
//                           : widget.controller.play();
//                     });
//                   },
//                 ),
//               ),

//             // 🎬 Bottom progress bar
//             if (_showControls)
//               Positioned(
//                 bottom: 20,
//                 left: 0,
//                 right: 0,
//                 child: VideoProgressIndicator(
//                   widget.controller,
//                   allowScrubbing: true,
//                   colors: const VideoProgressColors(
//                     playedColor: AppColors.red,
//                     bufferedColor: AppColors.white,
//                     backgroundColor: AppColors.transparent,
//                   ),
//                 ),
//               ),

//             // ❌ Exit button (top-left)
//             Positioned(
//               top: 20,
//               left: 20,
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:quiz/api_Services/app_url.dart';
// import 'package:quiz/model/subvideo_model.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:video_player/video_player.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VideoDetailsScreen extends StatefulWidget {
//   final String title;
//   final String description;
//   final SubVideoModel video;

//   const VideoDetailsScreen({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.video,
//   });

//   @override
//   State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
// }

// class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
//   VideoPlayerController? _controller;
//   bool _isInitialized = false;
//   bool _isLoading = true;
//   bool _isDownloading = false;
//   double _downloadProgress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }

//   Future<void> _initializeVideo() async {
//     final videoPath = widget.video.video;

//     if (videoPath == null || !videoPath.endsWith('.mp4')) {
//       print("❌ Invalid or missing video file: $videoPath");
//       setState(() => _isLoading = false);
//       return;
//     }

//     final videoUrl =
//         videoPath.startsWith('http')
//             ? videoPath
//             : "${AppUrl.imageBaseUrl}${videoPath.startsWith('/') ? '' : '/'}$videoPath";

//     try {
//       _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//       await _controller!.initialize();
//       _controller!.setLooping(true);

//       setState(() {
//         _isInitialized = true;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("❌ Video initialization failed: $e");
//       setState(() => _isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Unable to load video from: $videoUrl")),
//       );
//     }
//   }

//   /// ✅ Download Video Function
//   Future<void> _downloadVideo() async {
//     final videoPath = widget.video.video;
//     if (videoPath == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Video file not found!")));
//       return;
//     }

//     final videoUrl =
//         videoPath.startsWith('http')
//             ? videoPath
//             : "${AppUrl.imageBaseUrl}${videoPath.startsWith('/') ? '' : '/'}$videoPath";

//     // Request permission
//     if (Platform.isAndroid) {
//       final status = await Permission.storage.request();
//       if (!status.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Storage permission denied.")),
//         );
//         return;
//       }
//     } else if (Platform.isIOS) {
//       final status = await Permission.photos.request();
//       if (!status.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Photos permission denied.")),
//         );
//         return;
//       }
//     }

//     try {
//       setState(() {
//         _isDownloading = true;
//         _downloadProgress = 0.0;
//       });

//       // Get path
//       Directory dir;
//       if (Platform.isAndroid) {
//         dir = Directory('/storage/emulated/0/Camrera');
//         if (!await dir.exists()) {
//           dir = await getApplicationDocumentsDirectory();
//         }
//       } else {
//         dir = await getApplicationDocumentsDirectory();
//       }

//       final savePath = "${dir.path}/${widget.title.replaceAll(' ', '_')}.mp4";

//       // Download
//       Dio dio = Dio();
//       await dio.download(
//         videoUrl,
//         savePath,
//         onReceiveProgress: (received, total) {
//           if (total != -1) {
//             setState(() {
//               _downloadProgress = received / total;
//             });
//           }
//         },
//       );

//       setState(() {
//         _isDownloading = false;
//       });
//       Get.snackbar(
//         "Success",
//         "Video Download Sucessfully!",
//         colorText: AppColors.black,
//         backgroundColor: AppColors.transparent,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text("✅ Download complete! Saved to: $savePath"),
//       //     backgroundColor: Colors.green,
//       //   ),
//       //);
//     } catch (e) {
//       setState(() {
//         _isDownloading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("❌ Download failed: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.dispose();
//   }

//   void _goFullScreen() async {
//     if (_controller == null || !_controller!.value.isInitialized) return;

//     await SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoPlayer(controller: _controller!),
//       ),
//     );

//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     final image = widget.video.vedioImage;
//     final imageUrl =
//         (image != null && image.isNotEmpty)
//             ? (image.startsWith('http')
//                 ? image
//                 : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image")
//             : null;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade300,
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: screenHeight * 0.07, left: 20),
//             child: const Text(
//               "Video Trainings",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF111133),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.85,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.06,
//                   vertical: screenHeight * 0.03,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: SizedBox(
//                         height: 200,
//                         width: double.infinity,
//                         child:
//                             _isLoading
//                                 ? const Center(
//                                   child: CircularProgressIndicator(),
//                                 )
//                                 : _isInitialized && _controller != null
//                                 ? Stack(
//                                   alignment: Alignment.bottomCenter,
//                                   children: [
//                                     AspectRatio(
//                                       aspectRatio:
//                                           _controller!.value.aspectRatio,
//                                       child: VideoPlayer(_controller!),
//                                     ),
//                                     VideoProgressIndicator(
//                                       _controller!,
//                                       allowScrubbing: true,
//                                     ),
//                                     Center(
//                                       child: IconButton(
//                                         icon: Icon(
//                                           _controller!.value.isPlaying
//                                               ? Icons.pause_circle
//                                               : Icons.play_circle,
//                                           size: 60,
//                                           color: AppColors.grey,
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             _controller!.value.isPlaying
//                                                 ? _controller!.pause()
//                                                 : _controller!.play();
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: 160,
//                                       right: 33,
//                                       child:
//                                           _isDownloading
//                                               ? SizedBox(
//                                                 width: 25,
//                                                 height: 25,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                       value: _downloadProgress,
//                                                       color: Colors.orange,
//                                                       strokeWidth: 3,
//                                                     ),
//                                               )
//                                               : IconButton(
//                                                 icon: const Icon(
//                                                   Icons.download_outlined,
//                                                   color: Colors.black,
//                                                   size: 22,
//                                                 ),
//                                                 onPressed: _downloadVideo,
//                                               ),
//                                     ),
//                                     Positioned(
//                                       top: 160,
//                                       right: 3,
//                                       child: IconButton(
//                                         icon: const Icon(
//                                           Icons.crop_free,
//                                           color: Colors.black,
//                                           size: 20,
//                                         ),
//                                         onPressed: _goFullScreen,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                                 : (imageUrl != null
//                                     ? Image.network(imageUrl, fit: BoxFit.cover)
//                                     : Container(
//                                       color: Colors.grey.shade300,
//                                       child: const Icon(
//                                         Icons.image_not_supported,
//                                       ),
//                                     )),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 widget.title,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 "Intro to life",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Description:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       widget.description,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                         height: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 🔹 Fullscreen Video Player
// class FullScreenVideoPlayer extends StatefulWidget {
//   final VideoPlayerController controller;

//   const FullScreenVideoPlayer({super.key, required this.controller});

//   @override
//   State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
// }

// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   bool _showControls = true;

//   void _toggleControls() {
//     setState(() => _showControls = !_showControls);
//   }

//   void _seekForward() {
//     final current = widget.controller.value.position;
//     final duration = widget.controller.value.duration;
//     final target = current + const Duration(seconds: 10);
//     widget.controller.seekTo(target < duration ? target : duration);
//   }

//   void _seekBackward() {
//     final current = widget.controller.value.position;
//     final target = current - const Duration(seconds: 10);
//     widget.controller.seekTo(target > Duration.zero ? target : Duration.zero);
//   }

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: _toggleControls,
//         onDoubleTapDown: (details) {
//           final width = MediaQuery.of(context).size.width;
//           if (details.localPosition.dx < width / 2) {
//             _seekBackward();
//           } else {
//             _seekForward();
//           }
//         },
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Center(
//               child: AspectRatio(
//                 aspectRatio: widget.controller.value.aspectRatio,
//                 child: VideoPlayer(widget.controller),
//               ),
//             ),
//             if (_showControls)
//               Center(
//                 child: IconButton(
//                   icon: Icon(
//                     widget.controller.value.isPlaying
//                         ? Icons.pause_circle
//                         : Icons.play_circle,
//                     color: Colors.white,
//                     size: 80,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       widget.controller.value.isPlaying
//                           ? widget.controller.pause()
//                           : widget.controller.play();
//                     });
//                   },
//                 ),
//               ),
//             if (_showControls)
//               Positioned(
//                 bottom: 20,
//                 left: 0,
//                 right: 0,
//                 child: VideoProgressIndicator(
//                   widget.controller,
//                   allowScrubbing: true,
//                   colors: const VideoProgressColors(
//                     playedColor: AppColors.red,
//                     bufferedColor: AppColors.white,
//                     backgroundColor: AppColors.transparent,
//                   ),
//                 ),
//               ),
//             Positioned(
//               top: 20,
//               left: 20,
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/model/subvideo_model.dart';
import 'package:quiz/utils/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_scanner/media_scanner.dart';

class VideoDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final SubVideoModel video;

  const VideoDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.video,
  });

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isLoading = true;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final videoPath = widget.video.video;

    if (videoPath == null || !videoPath.endsWith('.mp4')) {
      print("❌ Invalid or missing video file: $videoPath");
      setState(() => _isLoading = false);
      return;
    }

    final videoUrl =
        videoPath.startsWith('http')
            ? videoPath
            : "${AppUrl.imageBaseUrl}${videoPath.startsWith('/') ? '' : '/'}$videoPath";

    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _controller!.initialize();
      _controller!.setLooping(true);

      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
    } catch (e) {
      print("❌ Video initialization failed: $e");
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unable to load video from: $videoUrl")),
      );
    }
  }

  /// ✅ Download Video Function
  Future<void> _downloadVideo() async {
    final videoPath = widget.video.video;
    if (videoPath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Video file not found!")));
      return;
    }

    final videoUrl =
        videoPath.startsWith('http')
            ? videoPath
            : "${AppUrl.imageBaseUrl}${videoPath.startsWith('/') ? '' : '/'}$videoPath";

    // Request permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied.")),
      );
      return;
    }

    try {
      setState(() {
        _isDownloading = true;
        _downloadProgress = 0.0;
      });

      Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final savePath =
          "${dir.path}/${widget.title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.mp4";

      Dio dio = Dio();
      await dio.download(
        videoUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      // ✅ Scan file to make it visible in Gallery
      await MediaScanner.loadMedia(path: savePath);

      setState(() {
        _isDownloading = false;
      });

      Get.snackbar(
        "Success",
        "Video Download Succesfully!",
        colorText: AppColors.black,
        backgroundColor: AppColors.transparent,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Download failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _goFullScreen() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(controller: _controller!),
      ),
    );

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final image = widget.video.vedioImage;
    final imageUrl =
        (image != null && image.isNotEmpty)
            ? (image.startsWith('http')
                ? image
                : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image")
            : null;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.07, left: 20),
            child: const Text(
              "Video Trainings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111133),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child:
                            _isLoading
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : _isInitialized && _controller != null
                                ? Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    AspectRatio(
                                      aspectRatio:
                                          _controller!.value.aspectRatio,
                                      child: VideoPlayer(_controller!),
                                    ),
                                    VideoProgressIndicator(
                                      _controller!,
                                      allowScrubbing: true,
                                    ),
                                    Center(
                                      child: IconButton(
                                        icon: Icon(
                                          _controller!.value.isPlaying
                                              ? Icons.pause_circle
                                              : Icons.play_circle,
                                          size: 60,
                                          color: AppColors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _controller!.value.isPlaying
                                                ? _controller!.pause()
                                                : _controller!.play();
                                          });
                                        },
                                      ),
                                    ),

                                    // Positioned(
                                    //   top: 160,
                                    //   right: 40,
                                    //   child:
                                    //       _isDownloading
                                    //           ? SizedBox(
                                    //             width: 10,
                                    //             height: 15,
                                    //             child:
                                    //                 CircularProgressIndicator(
                                    //                   value: _downloadProgress,
                                    //                   color: AppColors.black,
                                    //                   strokeWidth: 3,
                                    //                 ),
                                    //           )
                                    //           : IconButton(
                                    //             icon: const Icon(
                                    //               Icons.download_outlined,
                                    //               color: Colors.black,
                                    //               size: 22,
                                    //             ),
                                    //             onPressed: _downloadVideo,
                                    //           ),
                                    // ),
                                    Positioned(
                                      top: 160,
                                      right: 36,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.download_outlined,
                                              color: Colors.black,
                                              size: 23,
                                            ),
                                            onPressed:
                                                _isDownloading
                                                    ? null
                                                    : _downloadVideo, // disable while downloading
                                          ),
                                          if (_isDownloading)
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                value:
                                                    _downloadProgress == 0
                                                        ? null
                                                        : _downloadProgress,
                                                color: Colors.black,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),

                                    Positioned(
                                      top: 160,
                                      right: 3,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.crop_free,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        onPressed: _goFullScreen,
                                      ),
                                    ),
                                  ],
                                )
                                : (imageUrl != null
                                    ? Image.network(imageUrl, fit: BoxFit.cover)
                                    : Container(
                                      color: Colors.grey.shade300,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                      ),
                                    )),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Description:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  const FullScreenVideoPlayer({super.key, required this.controller});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  bool _showControls = true;

  void _toggleControls() => setState(() => _showControls = !_showControls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),
            if (_showControls)
              Center(
                child: IconButton(
                  icon: Icon(
                    widget.controller.value.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: Colors.white,
                    size: 80,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.controller.value.isPlaying
                          ? widget.controller.pause()
                          : widget.controller.play();
                    });
                  },
                ),
              ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
