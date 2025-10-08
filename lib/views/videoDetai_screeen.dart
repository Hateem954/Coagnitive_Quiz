// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart' show Get;
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/signup_screen.dart';
// import 'package:quiz/views/video_screen.dart';

// class VideoDetailsScreen extends StatefulWidget {
//   const VideoDetailsScreen({super.key});

//   @override
//   State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
// }

// class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
//   int currentIndex = 0;

//   final List<Map<String, String>> videos = [
//     {
//       "title": "Motivation 01",
//       "subtitle": "Intro to life",
//       "duration": "05 Min",
//       "description":
//           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
//     },
//     {
//       "title": "Motivation 02",
//       "subtitle": "Career boost",
//       "duration": "08 Min",
//       "description":
//           "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.",
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final video = videos[currentIndex];
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.grey, // fallback background
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false, // Removes back arrow
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
//           height: screenHeight * 0.82,
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
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Thumbnail placeholder
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColors.greytextfields,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.play_circle_fill,
//                     size: 60,
//                     color: AppColors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 /// Title + Duration Row
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: screenWidth * 0.27,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.black,
//                           side: const BorderSide(
//                             color: AppColors.greytextfields,
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                         ),
//                         onPressed: () {
//                           // Sign up logic
//                           Get.to(VideoScreen());
//                         },
//                         child: Text(
//                           "Previous",
//                           style: TextStyle(
//                             fontSize: sp(14),
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: w(0.06)),
//                     SizedBox(
//                       width: screenWidth * 0.55,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.black,
//                           side: const BorderSide(
//                             color: AppColors.greytextfields,
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: Text(
//                           "Next",
//                           style: TextStyle(
//                             fontSize: sp(14),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/video_screen.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({super.key});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  int currentIndex = 0;

  final List<Map<String, String>> videos = [
    {
      "title": "Motivation 01",
      "subtitle": "Intro to life",
      "duration": "05 Min",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
    },
    {
      "title": "Motivation 02",
      "subtitle": "Career boost",
      "duration": "08 Min",
      "description":
          "Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final video = videos[currentIndex];
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes back arrow
        title: const Text(
          "Video Trainings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.82,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Thumbnail placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greytextfields,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.play_circle_fill,
                    size: 60,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 16),

                /// Title + Duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          video["subtitle"]!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      video["duration"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                /// Description
                const Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Text(
                  video["description"]!,
                  style: const TextStyle(fontSize: 13, color: AppColors.black),
                ),

                const Spacer(),

                /// Previous / Next Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black,
                          side: const BorderSide(
                            color: AppColors.greytextfields,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed:
                            currentIndex > 0
                                ? () {
                                  setState(() {
                                    currentIndex--;
                                  });
                                }
                                : null,
                        child: const Text(
                          "Previous",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black,
                          side: const BorderSide(
                            color: AppColors.greytextfields,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed:
                            currentIndex < videos.length - 1
                                ? () {
                                  setState(() {
                                    currentIndex++;
                                  });
                                }
                                : null,
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
