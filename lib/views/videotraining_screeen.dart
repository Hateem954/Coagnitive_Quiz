// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/videoDetai_screeen.dart';
// import 'package:quiz/views/video_screen.dart';

// class VideoTrainingsScreen extends StatelessWidget {
//   VideoTrainingsScreen({super.key});

//   /// Dummy data
//   final List<Map<String, String>> videos = [
//     {
//       "title": "Motivation To Life",
//       "description": "10 Videos - 6 Min Each",
//       "category": "Motivational",
//       "duration": "60 min",
//       "createdBy": "Dr. Boon",
//     },
//     {
//       "title": "Motivate to Career",
//       "description": "10 Videos - 5 Min Each",
//       "category": "Motivational",
//       "duration": "50 min",
//       "createdBy": "Dr. Boon",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false, // 🔹 Removes the back arrow
//         title: const Text(
//           "Video Trainings",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           width: double.infinity,
//           height: screenHeight * 0.78,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 8,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.06,
//               vertical: screenHeight * 0.02,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Filter Title
//                 const Text(
//                   "Filter",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//                 ),
//                 const SizedBox(height: 12),

//                 /// Filter Fields
//                 Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: [
//                     _buildFilterTextField("Category"),
//                     _buildFilterTextField("Trainer"),
//                     _buildFilterTextField("Duration"),
//                     _buildFilterTextField("No of videos"),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 /// Video List
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: videos.length,
//                     itemBuilder: (context, index) {
//                       final video = videos[index];
//                       return _buildVideoCard(video);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Video Card UI
//   Widget _buildVideoCard(Map<String, String> video) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF6A4C4C), // dark brown background
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Category & Duration Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildChip(video["category"] ?? "", Colors.red, Colors.white),
//               _buildChip(video["duration"] ?? "", Colors.white, Colors.black),
//             ],
//           ),
//           const SizedBox(height: 8),

//           /// Title
//           Text(
//             video["title"] ?? "",
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 6),

//           /// Description
//           Text(
//             video["description"] ?? "",
//             style: const TextStyle(fontSize: 14, color: Colors.white70),
//           ),
//           const SizedBox(height: 12),

//           /// Creator & Button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.pinkAccent,
//                     child: Icon(Icons.person, color: Colors.white, size: 18),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Created by\n${video["createdBy"]}",
//                     style: const TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Get.to(() => VideoScreen());
//                   Get.to(VideoDetailsScreen());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 10,
//                   ),
//                 ),
//                 child: const Text(
//                   "Start Now",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// Filter TextField Widget
//   Widget _buildFilterTextField(String hint) {
//     return SizedBox(
//       width: 150,
//       height: 40,
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
//           filled: true,
//           fillColor: Colors.grey.shade200,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(6),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   /// Reusable Chip
//   Widget _buildChip(String text, Color bgColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:quiz/model/video_model.dart';
// import 'package:quiz/provider/video_provider.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/videoDetai_screeen.dart';

// class VideoTrainingsScreen extends StatelessWidget {
//   const VideoTrainingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: const Text(
//           "Video Trainings",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//             fontSize: 22,
//           ),
//         ),
//       ),
//       body: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           width: double.infinity,
//           height: screenHeight * 0.78,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 8,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.06,
//               vertical: screenHeight * 0.02,
//             ),
//             child: Consumer<VideoProvider>(
//               builder: (context, provider, _) {
//                 if (provider.videos.isEmpty) {
//                   return const Center(child: Text("No videos available"));
//                 }

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// Filter Title
//                     const Text(
//                       "Filter",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 19,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     /// Filter Fields
//                     Wrap(
//                       spacing: 12,
//                       runSpacing: 12,
//                       children: [
//                         _buildFilterTextField("Category"),
//                         _buildFilterTextField("Trainer"),
//                         _buildFilterTextField("Duration"),
//                         _buildFilterTextField("No of videos"),
//                       ],
//                     ),
//                     const SizedBox(height: 20),

//                     /// Video Playlist
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: provider.videos.length,
//                         itemBuilder: (context, index) {
//                           final video = provider.videos[index];
//                           return _buildVideoCard(video, index, provider);
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Video Card UI
//   Widget _buildVideoCard(VideoModel video, int index, VideoProvider provider) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF6A4C4C), // dark brown background
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Category & Duration Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildChip(
//                 "Category", // placeholder (since VideoModel has no category)
//                 Colors.red,
//                 Colors.white,
//               ),

//               _buildChip("5 min", Colors.white, Colors.black),
//             ],
//           ),
//           const SizedBox(height: 8),

//           /// Title
//           Text(
//             video.title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 6),

//           /// Description
//           Text(
//             video.description,
//             style: const TextStyle(fontSize: 14, color: Colors.white70),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 12),

//           /// Creator & Button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: const [
//                   CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.pinkAccent,
//                     child: Icon(Icons.person, color: Colors.white, size: 18),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     "Created by Trainer",
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   provider.changeVideo(index);
//                   Get.to(() => const VideoDetailsScreen());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 10,
//                   ),
//                 ),
//                 child: const Text(
//                   "Start Now",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   /// Filter TextField Widget
//   Widget _buildFilterTextField(String hint) {
//     return SizedBox(
//       width: 150,
//       height: 40,
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
//           filled: true,
//           fillColor: Colors.grey.shade200,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(6),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   /// Reusable Chip
//   Widget _buildChip(String text, Color bgColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
//00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
                      // duration: "6 min each",
                      trainer: "Dr. Boon",
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

  /// 🔹 Styled Video Card
  Widget _buildVideoCard({
    required BuildContext context,
    required VideoModel video,
    required int index,
    required VideoProvider provider,
    required String categoryName,
    required int videoCount,
    // required String duration,
    required String trainer,
    required String categoryHashId,
  }) {
    return GestureDetector(
      onTap: () {
        // 🔹 Navigate using hashid
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
            /// LEFT SIDE (Text content)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Chips Row
                  Row(
                    children: [
                      _buildChip(categoryName, Colors.red, Colors.white),
                      const SizedBox(width: 8),
                      // _buildChip("60 min", Colors.white, Colors.black),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Title
                  Text(
                    video.title.isNotEmpty ? video.title : "Motivation To Life",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// Subtitle
                  Text(
                    "$videoCount Videos ",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),

                  /// Trainer Row
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

            /// RIGHT SIDE (Image Thumbnail)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomImageContainer(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.25,
                imageUrl: AppImages.error_image,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Chip Widget
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
