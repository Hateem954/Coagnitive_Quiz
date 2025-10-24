// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quiz/model/subvideo_model.dart';
// import 'package:quiz/provider/subvideo_provider.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:video_player/video_player.dart';

// class VideoScreen extends StatefulWidget {
//   final String hashid;

//   const VideoScreen({super.key, required this.hashid});

//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//   @override
//   void initState() {
//     super.initState();
//     debugPrint("🎯 Fetching SubVideos with hashid: ${widget.hashid}");

//     Future.microtask(() {
//       final provider = Provider.of<SubVideoProvider>(context, listen: false);
//       provider.fetchSubVideos(widget.hashid);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       body: Stack(
//         children: [
//           // 🔹 Title at the top
//           Padding(
//             padding: EdgeInsets.only(top: screenHeight * 0.05, left: 20),
//             child: const Text(
//               "Video Trainings",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.black,
//               ),
//             ),
//           ),

//           // 🔹 Bottom-aligned video container
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.82,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.06,
//                   vertical: screenHeight * 0.02,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),

//                     // 🔹 Dynamic Video Grid
//                     Expanded(
//                       child: Consumer<SubVideoProvider>(
//                         builder: (context, videoProvider, child) {
//                           if (videoProvider.isLoading) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }

//                           if (videoProvider.subVideos.isEmpty) {
//                             return const Center(
//                               child: Text("No videos available"),
//                             );
//                           }

//                           final videos = videoProvider.subVideos;

//                           return GridView.builder(
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2, // ✅ 2 videos per row
//                                   crossAxisSpacing: 12,
//                                   mainAxisSpacing: 12,
//                                   childAspectRatio: 0.85,
//                                 ),
//                             itemCount: videos.length,
//                             itemBuilder: (context, index) {
//                               final video = videos[index];
//                               final imageUrl =
//                                   (video.vedioImage != null &&
//                                           video.vedioImage!.isNotEmpty)
//                                       ? "https://d8ca871017cc.ngrok-free.app/${video.vedioImage}"
//                                       : null;

//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (_) =>
//                                               VideoPlayerScreen(video: video),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade100,
//                                     borderRadius: BorderRadius.circular(16),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 6,
//                                         offset: Offset(0, 3),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       // Thumbnail
//                                       ClipRRect(
//                                         borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(16),
//                                           topRight: Radius.circular(16),
//                                         ),
//                                         child:
//                                             imageUrl == null
//                                                 ? Container(
//                                                   height: 100,
//                                                   color: Colors.grey.shade300,
//                                                   child: const Center(
//                                                     child: Icon(
//                                                       Icons.broken_image,
//                                                       size: 40,
//                                                       color: AppColors.black,
//                                                     ),
//                                                   ),
//                                                 )
//                                                 : Image.network(
//                                                   imageUrl,
//                                                   height: 100,
//                                                   width: double.infinity,
//                                                   fit: BoxFit.cover,
//                                                   errorBuilder: (
//                                                     context,
//                                                     error,
//                                                     stackTrace,
//                                                   ) {
//                                                     return Container(
//                                                       height: 100,
//                                                       color:
//                                                           Colors.grey.shade300,
//                                                       child: const Center(
//                                                         child: Icon(
//                                                           Icons.broken_image,
//                                                           size: 40,
//                                                           color:
//                                                               AppColors.black,
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                       ),

//                                       // Video details
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               video.title.isNotEmpty
//                                                   ? video.title
//                                                   : "Untitled Video",
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             Text(
//                                               video.description,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: const TextStyle(
//                                                 fontSize: 12,
//                                                 color: AppColors.black,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 4),
//                                             const Text(
//                                               "05 min",
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
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

// // ✅ Video Player Screen
// class VideoPlayerScreen extends StatefulWidget {
//   final SubVideoModel video;

//   const VideoPlayerScreen({super.key, required this.video});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   VideoPlayerController? _controller;
//   bool _videoError = false;

//   @override
//   void initState() {
//     super.initState();
//     final videoUrl =
//         "https://d8ca871017cc.ngrok-free.app/${widget.video.video}";

//     debugPrint("▶️ Playing video from: $videoUrl");

//     _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
//       ..initialize()
//           .then((_) {
//             setState(() {});
//             _controller!.play();
//           })
//           .catchError((_) {
//             setState(() {
//               _videoError = true;
//             });
//           });
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imageUrl =
//         widget.video.vedioImage != null && widget.video.vedioImage!.isNotEmpty
//             ? "https://d8ca871017cc.ngrok-free.app/${widget.video.vedioImage}"
//             : null;

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.video.title)),
//       body: Center(
//         child:
//             _videoError
//                 ? const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.error, size: 60, color: AppColors.red),
//                     SizedBox(height: 10),
//                     Text(
//                       "⚠️ Failed to load video",
//                       style: TextStyle(color: AppColors.red),
//                     ),
//                   ],
//                 )
//                 : (_controller != null && _controller!.value.isInitialized)
//                 ? AspectRatio(
//                   aspectRatio: _controller!.value.aspectRatio,
//                   child: VideoPlayer(_controller!),
//                 )
//                 : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (imageUrl != null)
//                       Image.network(
//                         imageUrl,
//                         height: 200,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 200,
//                             color: AppColors.grey,
//                             child: const Icon(
//                               Icons.broken_image,
//                               size: 50,
//                               color: AppColors.black,
//                             ),
//                           );
//                         },
//                       )
//                     else
//                       Container(
//                         height: 200,
//                         color: AppColors.grey,
//                         child: const Icon(
//                           Icons.broken_image,
//                           size: 50,
//                           color: AppColors.black,
//                         ),
//                       ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       "Loading video...",
//                       style: TextStyle(color: AppColors.black),
//                     ),
//                     const SizedBox(height: 10),
//                     const CircularProgressIndicator(),
//                   ],
//                 ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/model/subvideo_model.dart';
import 'package:quiz/provider/subvideo_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/videoDetai_screeen.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String hashid;

  const VideoScreen({super.key, required this.hashid});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("🎯 Fetching SubVideos with hashid: ${widget.hashid}");

    Future.microtask(() {
      final provider = Provider.of<SubVideoProvider>(context, listen: false);
      provider.fetchSubVideos(widget.hashid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          // 🔹 Title
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05, left: 20),
            child: const Text(
              "Video Trainings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),

          // 🔹 Content area
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.82,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),

                    // 🔹 Video grid
                    Expanded(
                      child: Consumer<SubVideoProvider>(
                        builder: (context, videoProvider, child) {
                          if (videoProvider.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (videoProvider.subVideos.isEmpty) {
                            return const Center(
                              child: Text("No videos available"),
                            );
                          }

                          final videos = videoProvider.subVideos;

                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              final video = videos[index];
                              // final imageUrl =
                              //     (video.vedioImage != null &&
                              //             video.vedioImage!.isNotEmpty)
                              //         ? "https://d8ca871017cc.ngrok-free.app/${video.vedioImage}"
                              //         : null;

                              final imageUrl =
                                  (video.vedioImage != null &&
                                          video.vedioImage!.isNotEmpty)
                                      ? (video.vedioImage!.startsWith('http')
                                          ? video.vedioImage
                                          : "${AppUrl.imageBaseUrl}${video.vedioImage!.startsWith('/') ? '' : '/'}${video.vedioImage}")
                                      : null;

                              return GestureDetector(
                                onTap: () {
                                  // ✅ Navigate and pass title & description
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => VideoDetailsScreen(
                                            title:
                                                video.title.isNotEmpty
                                                    ? video.title
                                                    : "Untitled Video",
                                            description: video.description,
                                            video:
                                                video, // optional: send full model
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Thumbnail
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        child:
                                            imageUrl == null
                                                ? Container(
                                                  height: 100,
                                                  color: Colors.grey.shade300,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      size: 40,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                )
                                                : Image.network(
                                                  imageUrl,
                                                  height: 100,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) {
                                                    return Container(
                                                      height: 100,
                                                      color:
                                                          Colors.grey.shade300,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.broken_image,
                                                          size: 40,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                      ),

                                      // Video info
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              video.title.isNotEmpty
                                                  ? video.title
                                                  : "Untitled Video",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              video.description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            const Text(
                                              "05 min",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
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
