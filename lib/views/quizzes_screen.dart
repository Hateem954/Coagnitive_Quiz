// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/Controller/quiz_controller.dart';
// import 'package:quiz/views/level_screen.dart'; // ✅ Import your LevelScreen
// import 'package:quiz/utils/colors.dart';

// class Quizzes extends StatelessWidget {
//   Quizzes({super.key});

//   final QuizController quizController = Get.put(QuizController());

//   @override
//   Widget build(BuildContext context) {
//     // Fetch quizzes when screen opens
//     quizController.fetchQuizzes();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Quiz For You",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1A1A40),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // ✅ Quiz list from Controller
//               Expanded(
//                 child: Obx(() {
//                   if (quizController.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (quizController.errorMessage.isNotEmpty) {
//                     return Center(
//                       child: Text(
//                         quizController.errorMessage.value,
//                         style: const TextStyle(color: AppColors.red),
//                       ),
//                     );
//                   }

//                   if (quizController.quizzes.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         "No quizzes available",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     );
//                   }

//                   return ListView.builder(
//                     itemCount: quizController.quizzes.length,
//                     itemBuilder: (context, index) {
//                       final quiz = quizController.quizzes[index];

//                       return GestureDetector(
//                         onTap: () {
//                           // ✅ Navigate to LevelScreen with hashid and title
//                           Get.to(
//                             () => LevelScreen(
//                               hashid: quiz.hashid.toString(),
//                               title: quiz.title,
//                               id: quiz.id.toString(),
//                             ),
//                           );
//                         },
//                         child: Column(
//                           children: [
//                             _quizCard(
//                               quizCode: "Q-${quiz.id}-${quiz.hashid}",
//                               category: quiz.category.name,
//                               categoryColor: AppColors.black,
//                               time: "5 min",
//                               title: quiz.title,
//                               questions: quiz.description,
//                               creator: "System",
//                             ),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🔹 Quiz Card Widget
//   Widget _quizCard({
//     required String quizCode,
//     required String category,
//     required Color categoryColor,
//     required String time,
//     required String title,
//     required String questions,
//     required String creator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           quizCode,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: AppColors.black,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade800,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Category + Time
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       category,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: categoryColor,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       time,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               // Title
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.white,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 questions,
//                 style: const TextStyle(fontSize: 13, color: AppColors.white),
//               ),

//               const SizedBox(height: 12),

//               // Creator + Button
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 16,
//                     backgroundColor: AppColors.white,
//                     child: Icon(Icons.person, color: AppColors.black, size: 20),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Created by\n$creator",
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: AppColors.white,
//                     ),
//                   ),
//                   const Spacer(),
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     color: AppColors.white,
//                     size: 18,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/quiz_controller.dart';
import 'package:quiz/views/level_screen.dart';
import 'package:quiz/utils/colors.dart';

class Quizzes extends StatelessWidget {
  Quizzes({super.key});

  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Fetch quizzes when screen opens
    quizController.fetchQuizzes();

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          // 🔹 Title at top
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05, left: 20),
            child: const Text(
              "Quiz For You",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),

          // 🔹 Bottom-aligned card
          Align(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    // 🔹 Dynamic Quiz List
                    Expanded(
                      child: Obx(() {
                        if (quizController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (quizController.errorMessage.isNotEmpty) {
                          return Center(
                            child: Text(
                              quizController.errorMessage.value,
                              style: const TextStyle(color: AppColors.red),
                            ),
                          );
                        }

                        if (quizController.quizzes.isEmpty) {
                          return const Center(
                            child: Text(
                              "No quizzes available",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: quizController.quizzes.length,
                          itemBuilder: (context, index) {
                            final quiz = quizController.quizzes[index];

                            return GestureDetector(
                              onTap: () {
                                // ✅ Navigate to LevelScreen with hashid and title
                                Get.to(
                                  () => LevelScreen(
                                    hashid: quiz.hashid.toString(),
                                    title: quiz.title,
                                    id: quiz.id.toString(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  _quizCard(
                                    // quizCode: "Q-${quiz.id}-${quiz.hashid}",
                                    category: quiz.category.name,
                                    categoryColor: AppColors.black,
                                    time: "5 min",
                                    title: quiz.title,
                                    questions: quiz.description,
                                    creator: "System",
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            );
                          },
                        );
                      }),
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

  /// 🔹 Reusable Quiz Card Widget
  Widget _quizCard({
    // required String quizCode,
    required String category,
    required Color categoryColor,
    required String time,
    required String title,
    required String questions,
    required String creator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   quizCode,
        //   style: const TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w600,
        //     color: AppColors.black,
        //   ),
        // ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Category + Time
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: categoryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 🔹 Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4),

              // 🔹 Description
              Text(
                questions,
                style: const TextStyle(fontSize: 13, color: AppColors.white),
              ),
              const SizedBox(height: 12),

              // 🔹 Creator Row
              Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.white,
                    child: Icon(Icons.person, color: AppColors.black, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Created by\n$creator",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
