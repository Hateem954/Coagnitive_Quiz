import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/perform_quiz_controller.dart';
import 'package:quiz/model/perform_quiz_model.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/home_screen.dart';
import 'package:quiz/views/message_screen.dart';
import 'package:quiz/views/videotraining_screeen.dart';
import 'package:quiz/views/map_screen.dart';

class YourQuizzes extends StatefulWidget {
  const YourQuizzes({super.key});

  @override
  State<YourQuizzes> createState() => _YourQuizzesState();
}

class _YourQuizzesState extends State<YourQuizzes> {
  final QuizResultController controller = Get.put(QuizResultController());
  int _selectedIndex = 1; // Default: Quizzes tab

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchQuizResults();
    });
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Get.offAll(() => const HomeScreen());
        break;
      case 1:
        // Stay on current screen
        break;
      case 2:
        Get.offAll(() => VideoTrainingsScreen());
        break;
      case 3:
        Get.offAll(() => GoogleMapPage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double w(double value) => screenWidth * value;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              Expanded(
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
            ],
          ),
        ),
      ),

      // ✅ Floating Chat Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChatScreen());
        },
        backgroundColor: AppColors.darkblue,
        child: const Icon(Icons.message, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ✅ Bottom Navigation Bar
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
                _bottomNavItem(Icons.home, "Home", 0),
                _bottomNavItem(Icons.grid_view, "Quizzes", 1),
                const SizedBox(width: 40),
                _bottomNavItem(Icons.video_library, "Videos", 2),
                _bottomNavItem(Icons.location_on, "Location", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, String label, int index) {
    final bool isActive = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onNavTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.darkblue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
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

/// ✅ Quiz List Section
class YourQuizzesContent extends StatelessWidget {
  final List<QuizResult> quizList;
  const YourQuizzesContent({super.key, required this.quizList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children:
          quizList
              .map(
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
              )
              .toList(),
    );
  }
}

/// ✅ Quiz Card Widget
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
