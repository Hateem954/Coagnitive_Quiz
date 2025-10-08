// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:quiz/views/Quiz_questionscreen.dart';

// class Quizzes extends StatelessWidget {
//   const Quizzes({super.key});

//   @override
//   Widget build(BuildContext context) {
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

//               // ✅ Quiz list
//               Expanded(
//                 child: ListView(
//                   children: [
//                     _quizCard(
//                       quizCode: "Q-452-456",
//                       category: "General Knowledge",
//                       categoryColor: Colors.red,
//                       time: "5 min",
//                       title: "Stress Checker",
//                       questions: "10 Questions - 5 Min",
//                       creator: "Dr. Boon",
//                     ),
//                     const SizedBox(height: 20),
//                     _quizCard(
//                       quizCode: "Q-452-466",
//                       category: "Mind Meld",
//                       categoryColor: Colors.red,
//                       time: "3 min",
//                       title: "Cerebral Challenge",
//                       questions: "10 Questions - 5 Min",
//                       creator: "Dr. Boon",
//                     ),
//                   ],
//                 ),
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
//             color: Colors.black54,
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
//                 color: Colors.black.withOpacity(0.1),
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
//                       color: Colors.white,
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
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       time,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
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
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 questions,
//                 style: const TextStyle(fontSize: 13, color: Colors.white70),
//               ),

//               const SizedBox(height: 12),

//               // Creator + Button
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.person, color: Colors.black87, size: 20),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Created by\n$creator",
//                     style: const TextStyle(fontSize: 12, color: Colors.white),
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {
//                       Get.to(QuizQuestionScreen());
//                     },
//                     child: const Text(
//                       "Start Now",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
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
import 'package:quiz/views/level_screen.dart'; // ✅ Import your LevelScreen
import 'package:quiz/utils/colors.dart';

class Quizzes extends StatelessWidget {
  Quizzes({super.key});

  final QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    // Fetch quizzes when screen opens
    quizController.fetchQuizzes();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quiz For You",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A40),
                ),
              ),
              const SizedBox(height: 16),

              // ✅ Quiz list from Controller
              Expanded(
                child: Obx(() {
                  if (quizController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
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
                              quizCode: "Q-${quiz.id}-${quiz.hashid}",
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
    );
  }

  /// 🔹 Quiz Card Widget
  Widget _quizCard({
    required String quizCode,
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
        Text(
          quizCode,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
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
              // Category + Time
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

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                questions,
                style: const TextStyle(fontSize: 13, color: AppColors.white),
              ),

              const SizedBox(height: 12),

              // Creator + Button
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
                    style: const TextStyle(fontSize: 12, color: AppColors.white),
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
