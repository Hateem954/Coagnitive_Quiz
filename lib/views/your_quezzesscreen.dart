// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/Controller/perform_quiz_controller.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/model/perform_quiz_model.dart';
// import 'home_screen.dart';

// class YourQuizzes extends StatefulWidget {
//   const YourQuizzes({super.key});

//   @override
//   State<YourQuizzes> createState() => _YourQuizzesState();
// }

// class _YourQuizzesState extends State<YourQuizzes> {
//   final QuizResultController controller = Get.put(QuizResultController());
//   int _selectedIndex = 1; // default = Quizzes tab

//   @override
//   void initState() {
//     super.initState();

//     // ✅ Run fetch AFTER first frame (to avoid “setState during build” error)
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchQuizResults();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     double w(double value) => screenWidth * value;

//     return Scaffold(
//       backgroundColor: const Color(
//         0xFFF4F4F6,
//       ), // light grey background like screenshot
//       body: SafeArea(
//         child: Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (controller.errorMessage.isNotEmpty) {
//             return Center(
//               child: Text(
//                 controller.errorMessage.value,
//                 style: const TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             );
//           } else if (controller.quizResults.isEmpty) {
//             return const Center(child: Text("No quizzes found."));
//           } else {
//             return YourQuizzesContent(quizList: controller.quizResults);
//           }
//         }),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.snackbar("Action", "Create new quiz tapped");
//         },
//         backgroundColor: AppColors.darkblue,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: SizedBox(
//           height: 60,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: w(0.001)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _bottomNavItem(Icons.home, "Home", 0, context),
//                 _bottomNavItem(Icons.quiz, "Quizzes", 1, context),
//                 SizedBox(width: w(0.1)), // space for FAB
//                 _bottomNavItem(Icons.bar_chart, "Results", 2, context),
//                 _bottomNavItem(Icons.lightbulb, "Advice", 3, context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Bottom Nav Item
//   Widget _bottomNavItem(
//     IconData icon,
//     String label,
//     int index,
//     BuildContext context,
//   ) {
//     final bool isActive = _selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           if (index == 0) {
//             Get.offAll(() => const HomeScreen());
//           } else {
//             setState(() {
//               _selectedIndex = index;
//             });
//           }
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: isActive ? AppColors.darkblue : Colors.transparent,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Icon(
//                 icon,
//                 color: isActive ? Colors.white : Colors.grey,
//                 size: 22,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isActive ? AppColors.darkblue : Colors.grey,
//                 fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ✅ Clean and minimal quizzes content (like screenshot)
// class YourQuizzesContent extends StatelessWidget {
//   final List<QuizResult> quizList;
//   const YourQuizzesContent({super.key, required this.quizList});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//       children: [
//         const Text(
//           "Your Quizzes",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             color: Color(0xFF1A1A40),
//           ),
//         ),
//         const SizedBox(height: 20),

//         // ✅ Build quiz cards from API list
//         ...quizList.map(
//           (quiz) => Padding(
//             padding: const EdgeInsets.only(bottom: 15),
//             child: _quizCard(
//               title: quiz.quiz?.title ?? "Untitled Quiz",
//               date:
//                   (quiz.createdAt != null)
//                       ? quiz.createdAt!.toLocal().toString().split(' ')[0]
//                       : "No date",
//               score: quiz.score?.toString() ?? "-",
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _quizCard({
//     required String title,
//     required String date,
//     required String score,
//   }) {
//     // You can randomize colors for demo or map based on quiz name
//     final Color bgColor =
//         title.contains("Stress")
//             ? const Color(0xFFE6E9FF)
//             : title.contains("Knowledge")
//             ? const Color(0xFFFFE6E9)
//             : const Color(0xFFE6F0FF);

//     final Color iconColor =
//         title.contains("Stress")
//             ? const Color(0xFF6A6AFF)
//             : title.contains("Knowledge")
//             ? const Color(0xFFFF6A6A)
//             : const Color(0xFF6AB6FF);

//     final IconData icon =
//         title.contains("Stress")
//             ? Icons.functions
//             : title.contains("Knowledge")
//             ? Icons.extension
//             : Icons.bar_chart;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Icon Container
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: bgColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: iconColor, size: 26),
//           ),
//           const SizedBox(width: 12),

//           // Quiz title + date
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   date,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),

//           // “Result” button
//           TextButton.icon(
//             onPressed: () {
//               Get.snackbar("Result", "Score: $score");
//             },
//             icon: const Icon(
//               Icons.stacked_bar_chart,
//               color: Color(0xFF4A4AFF),
//               size: 18,
//             ),
//             label: const Text(
//               "Result",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF4A4AFF),
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               minimumSize: Size.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/perform_quiz_controller.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/model/perform_quiz_model.dart';
import 'home_screen.dart';

class YourQuizzes extends StatefulWidget {
  const YourQuizzes({super.key});

  @override
  State<YourQuizzes> createState() => _YourQuizzesState();
}

class _YourQuizzesState extends State<YourQuizzes> {
  final QuizResultController controller = Get.put(QuizResultController());
  int _selectedIndex = 1; // default = Quizzes tab

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchQuizResults();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double w(double value) => screenWidth * value;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (controller.quizResults.isEmpty) {
            return const Center(child: Text("No quizzes found."));
          } else {
            return YourQuizzesContent(quizList: controller.quizResults);
          }
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar("Action", "Create new quiz tapped");
        },
        backgroundColor: AppColors.darkblue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(0.001)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomNavItem(Icons.home, "Home", 0, context),
                _bottomNavItem(Icons.quiz, "Quizzes", 1, context),
                SizedBox(width: w(0.1)), // space for FAB
                _bottomNavItem(Icons.bar_chart, "Results", 2, context),
                _bottomNavItem(Icons.lightbulb, "Advice", 3, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom Nav Item
  Widget _bottomNavItem(
    IconData icon,
    String label,
    int index,
    BuildContext context,
  ) {
    final bool isActive = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            Get.offAll(() => const HomeScreen());
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.darkblue : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? AppColors.darkblue : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Clean and minimal quizzes content (like screenshot)
class YourQuizzesContent extends StatelessWidget {
  final List<QuizResult> quizList;
  const YourQuizzesContent({super.key, required this.quizList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        const Text(
          "Your Quizzes",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A40),
          ),
        ),
        const SizedBox(height: 20),

        // ✅ Build quiz cards from API list
        ...quizList.map(
          (quiz) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: QuizCard(
              title: quiz.quiz?.title ?? "Untitled Quiz",
              date:
                  (quiz.createdAt != null)
                      ? quiz.createdAt!.toLocal().toString().split(' ')[0]
                      : "No date",
              score: quiz.score?.toString() ?? "-",
            ),
          ),
        ),
      ],
    );
  }
}

/// ✅ A separate stateful card widget to show/hide score on button click
class QuizCard extends StatefulWidget {
  final String title;
  final String date;
  final String score;

  const QuizCard({
    super.key,
    required this.title,
    required this.date,
    required this.score,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  bool _showScore = false;

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        widget.title.contains("Stress")
            ? const Color(0xFFE6E9FF)
            : widget.title.contains("Knowledge")
            ? const Color(0xFFFFE6E9)
            : const Color(0xFFE6F0FF);

    final Color iconColor =
        widget.title.contains("Stress")
            ? const Color(0xFF6A6AFF)
            : widget.title.contains("Knowledge")
            ? const Color(0xFFFF6A6A)
            : const Color(0xFF6AB6FF);

    final IconData icon =
        widget.title.contains("Stress")
            ? Icons.functions
            : widget.title.contains("Knowledge")
            ? Icons.extension
            : Icons.bar_chart;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 12),

              // Quiz title + date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // “Result” button
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _showScore = !_showScore;
                  });
                },
                icon: const Icon(
                  Icons.stacked_bar_chart,
                  color: Color(0xFF4A4AFF),
                  size: 18,
                ),
                label: Text(
                  _showScore ? "Hide" : "Result",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4A4AFF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  minimumSize: Size.zero,
                ),
              ),
            ],
          ),

          // ✅ Animated score section
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                _showScore
                    ? Padding(
                      padding: const EdgeInsets.only(left: 60, top: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF4A4AFF),
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Score: ${widget.score}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF1A1A40),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
