import 'package:flutter/material.dart';
import 'package:quiz/model/subvideo_model.dart';
import 'package:quiz/utils/colors.dart';

class VideoDetailsScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          // 🔹 Page Title
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

          // 🔹 Main content container
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
                    // 🔹 Video thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          (video.vedioImage != null &&
                                  video.vedioImage!.isNotEmpty)
                              ? Image.network(
                                "https://ea496fda75c2.ngrok-free.app/${video.vedioImage}",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                              : Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey.shade300,
                              ),
                    ),
                    const SizedBox(height: 15),

                    // 🔹 Title + Duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Intro to life",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "05 Min",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Description
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
                      description,
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
