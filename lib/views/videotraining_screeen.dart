import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/model/video_model.dart';
import 'package:quiz/provider/video_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/video_screen.dart';

class VideoTrainingsScreen extends StatelessWidget {
  const VideoTrainingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Video Trainings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 22,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.75,
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
            child: Consumer<VideoProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.categories.isEmpty) {
                  return const Center(child: Text("No videos available"));
                }

                return ListView.builder(
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final categoryWithVideo = provider.categories[index];
                    final video = categoryWithVideo.latestVideo;

                    if (video == null) {
                      return const SizedBox.shrink();
                    }

                    return _buildVideoCard(
                      context: context,
                      video: video,
                      index: index,
                      provider: provider,
                      categoryName: categoryWithVideo.category.name,
                      videoCount: categoryWithVideo.videosCount,
                      trainer: "Admin",
                      categoryHashId: categoryWithVideo.category.hashid,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Video Card Widget
  Widget _buildVideoCard({
    required BuildContext context,
    required VideoModel video,
    required int index,
    required VideoProvider provider,
    required String categoryName,
    required int videoCount,
    required String trainer,
    required String categoryHashId,
  }) {
    // 🔹 Construct the proper image URL
    final image = video.vedioImage;
    final imageUrl =
        (image != null && image.isNotEmpty)
            ? (image.startsWith('https')
                ? image
                : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image")
            : null;

    print("🖼️ Video Thumbnail URL: $imageUrl");

    return GestureDetector(
      onTap: () {
        // 🔹 Navigate to video details using hashid
        Get.to(() => VideoScreen(hashid: categoryHashId));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT SIDE — Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildChip(categoryName, Colors.red, Colors.white),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    video.title.isNotEmpty ? video.title : "Motivation To Life",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$videoCount Videos ",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.pinkAccent,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Created by $trainer",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// RIGHT SIDE — Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomImageContainer(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.25,
                imageUrl: imageUrl ?? AppImages.error_image,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Category Chip
  Widget _buildChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
