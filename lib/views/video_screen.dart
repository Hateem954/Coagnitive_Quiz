import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/model/subvideo_model.dart';
import 'package:quiz/provider/subvideo_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String hashid; // ✅ we will pass hashid from previous screen

  const VideoScreen({super.key, required this.hashid});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Show hashid in debug console
    debugPrint("🎯 Fetching SubVideos with hashid: ${widget.hashid}");

    // Fetch videos on screen load
    Future.microtask(() {
      final provider = Provider.of<SubVideoProvider>(context, listen: false);
      provider.fetchSubVideos(widget.hashid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Title Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Video Trainings",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),

            // ✅ Video Grid Section
            Expanded(
              child: Consumer<SubVideoProvider>(
                builder: (context, videoProvider, child) {
                  if (videoProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (videoProvider.subVideos.isEmpty) {
                    return const Center(child: Text("❌ No videos available"));
                  }

                  final videos = videoProvider.subVideos;

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // ✅ 2-column layout
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      final imageUrl =
                          (video.vedioImage != null &&
                                  video.vedioImage!.isNotEmpty)
                              ? "https://d8ca871017cc.ngrok-free.app/${video.vedioImage}"
                              : null;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VideoPlayerScreen(video: video),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child:
                                    imageUrl == null
                                        ? Container(
                                          height: 100,
                                          color: AppColors.grey,
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
                                              color: AppColors.grey,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  size: 40,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video.title.isNotEmpty
                                          ? video.title
                                          : "No Title",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      video.description,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "05 Min",
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
    );
  }
}

// ✅ Video Player Screen
class VideoPlayerScreen extends StatefulWidget {
  final SubVideoModel video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _videoError = false;

  @override
  void initState() {
    super.initState();
    final videoUrl =
        "https://d8ca871017cc.ngrok-free.app/${widget.video.video}";

    debugPrint("▶️ Playing video from: $videoUrl");

    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize()
          .then((_) {
            setState(() {});
            _controller!.play();
          })
          .catchError((_) {
            setState(() {
              _videoError = true;
            });
          });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        widget.video.vedioImage != null && widget.video.vedioImage!.isNotEmpty
            ? "https://d8ca871017cc.ngrok-free.app/${widget.video.vedioImage}"
            : null;

    return Scaffold(
      appBar: AppBar(title: Text(widget.video.title)),
      body: Center(
        child:
            _videoError
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.error, size: 60, color: AppColors.red),
                    SizedBox(height: 10),
                    Text(
                      "⚠️ Failed to load video",
                      style: TextStyle(color: AppColors.red),
                    ),
                  ],
                )
                : (_controller != null && _controller!.value.isInitialized)
                ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageUrl != null)
                      Image.network(
                        imageUrl,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: AppColors.grey,
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: AppColors.black,
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        height: 200,
                        color: AppColors.grey,
                        child: const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: AppColors.black,
                        ),
                      ),
                    const SizedBox(height: 16),
                    const Text(
                      "Loading video...",
                      style: TextStyle(color: AppColors.black),
                    ),
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(),
                  ],
                ),
      ),
    );
  }
}
