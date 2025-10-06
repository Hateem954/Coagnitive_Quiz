// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/Controller/get_category_quiz_controller.dart'; // ✅ Controller
// import 'package:quiz/utils/colors.dart';
// import 'home_screen.dart';

// class CategoryQuizScreen extends StatefulWidget {
//   final String hashid;
//   const CategoryQuizScreen({super.key, required this.hashid});

//   @override
//   State<CategoryQuizScreen> createState() => _CategoryQuizScreenState();
// }

// class _CategoryQuizScreenState extends State<CategoryQuizScreen> {
//   int _selectedIndex = 1; // default = Quizzes tab
//   final CategoryQuizController quizController = Get.put(
//     CategoryQuizController(),
//   );

//   @override
//   void initState() {
//     super.initState();
//     debugPrint("CategoryQuizScreen opened with hashid: ${widget.hashid}");

//     /// 🔹 Fetch quizzes on screen load
//     quizController.fetchCategoryQuizzes(widget.hashid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     double w(double value) => screenWidth * value;

//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       body: SafeArea(
//         child: Obx(() {
//           if (quizController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (quizController.quizes.isEmpty) {
//             return const Center(
//               child: Text(
//                 "No quizzes found",
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ListView(
//               children: [
//                 const SizedBox(height: 40),
//                 const Text(
//                   "Your Quizzes",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1A1A40),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 /// 🔹 Dynamic quizzes from API
//                 ...quizController.quizes.map((quiz) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 15),
//                     child: _quizCard(
//                       bgColor: const Color(0xFFE6E9FF),
//                       icon: Icons.quiz,
//                       iconColor: AppColors.darkblue,
//                       title: quiz.title,
//                       date: quiz.createdAt, // ✅ Added
//                       hashid: quiz.hashid, // ✅ Added
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           );
//         }),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           debugPrint("FAB tapped with hashid: ${widget.hashid}");
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

//   /// 🔹 Bottom Nav Item
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
//               debugPrint(
//                 "BottomNav tapped → $label with hashid: ${widget.hashid}",
//               );
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

//   /// 🔹 Quiz Card Widget
//   Widget _quizCard({
//     required Color bgColor,
//     required IconData icon,
//     required Color iconColor,
//     required String title,
//     required String date,
//     required String hashid,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         debugPrint("Quiz tapped: $title | hashid: $hashid");
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 6,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: bgColor,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: iconColor, size: 28),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     date,
//                     style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//             TextButton.icon(
//               onPressed: () {
//                 debugPrint("Result button tapped: $title | hashid: $hashid");
//               },
//               icon: const Icon(
//                 Icons.stacked_bar_chart,
//                 color: AppColors.darkblue,
//                 size: 18,
//               ),
//               label: const Text(
//                 "Result",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: AppColors.darkblue,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/get_category_quiz_controller.dart'; // ✅ Controller
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'home_screen.dart';

class CategoryQuizScreen extends StatefulWidget {
  final String hashid;
  final String CategoryName;
  const CategoryQuizScreen({
    super.key,
    required this.hashid,
    required this.CategoryName,
  });

  @override
  State<CategoryQuizScreen> createState() => _CategoryQuizScreenState();
}

class _CategoryQuizScreenState extends State<CategoryQuizScreen> {
  int _selectedIndex = 1; // default = Quizzes tab
  final CategoryQuizController quizController = Get.put(
    CategoryQuizController(),
  );

  @override
  void initState() {
    super.initState();
    debugPrint("CategoryQuizScreen opened with hashid: ${widget.hashid}");

    /// 🔹 Fetch quizzes on screen load
    quizController.fetchCategoryQuizzes(widget.hashid);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double w(double value) => screenWidth * value;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "${widget.CategoryName} Quizzes",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A40),
                ),
              ),
              const SizedBox(height: 20),

              /// 🔹 Wrap dynamic data with Obx
              Expanded(
                child: Obx(() {
                  if (quizController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (quizController.quizes.isEmpty) {
                    return const Center(
                      child: Text(
                        "No quizzes found",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: quizController.quizes.length,
                    itemBuilder: (context, index) {
                      final quiz = quizController.quizes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: _quizCard(
                          duration: "5 min",
                          title: quiz.title,
                          questions: 10,
                          createdBy: "Dr. Boon",
                          hashid: quiz.hashid,
                          context: context,
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB tapped with hashid: ${widget.hashid}");
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

  /// 🔹 Bottom Nav Item
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
              debugPrint(
                "BottomNav tapped → $label with hashid: ${widget.hashid}",
              );
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

  /// 🔹 Custom Quiz Card
  Widget _quizCard({
    required String duration,
    required String title,
    required int questions,
    required String createdBy,
    required String hashid,
    required BuildContext context,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        debugPrint("Quiz tapped: $title | hashid: $hashid");
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF7C4D4D), // Brownish like screenshot
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT SIDE (Quiz Info)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$questions Questions • $duration",
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Created by $createdBy",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// RIGHT SIDE (Image)
            CustomImageContainer(
              height: screenHeight * 0.08,
              width: screenWidth * 0.25,
              imageUrl: AppImages.error_image,
            ),
          ],
        ),
      ),
    );
  }
}
