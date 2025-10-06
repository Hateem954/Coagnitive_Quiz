import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils/colors.dart';
import 'home_screen.dart';

class YourQuizzes extends StatefulWidget {
  const YourQuizzes({super.key});

  @override
  State<YourQuizzes> createState() => _YourQuizzesState();
}

class _YourQuizzesState extends State<YourQuizzes> {
  int _selectedIndex = 1; // default = Quizzes tab

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double w(double value) => screenWidth * value;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: const SafeArea(child: YourQuizzesContent()),

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
            // 👇 Instead of nesting HomeScreen, navigate back
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

/// ✅ Quizzes content
class YourQuizzesContent extends StatelessWidget {
  const YourQuizzesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40), // space before title
          const Text(
            "Your Quizzes",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A40),
            ),
          ),
          const SizedBox(height: 20),
          _quizCard(
            bgColor: const Color(0xFFE6E9FF),
            icon: Icons.functions,
            iconColor: const Color(0xFF6A6AFF),
            title: "Stress Checker",
            date: "20-09-2025",
          ),
          const SizedBox(height: 15),
          _quizCard(
            bgColor: const Color(0xFFFFE6E9),
            icon: Icons.extension,
            iconColor: const Color(0xFFFF6A6A),
            title: "General Knowledge",
            date: "18-09-2025",
          ),
          const SizedBox(height: 15),
          _quizCard(
            bgColor: const Color(0xFFE6F0FF),
            icon: Icons.bar_chart,
            iconColor: const Color(0xFF6AB6FF),
            title: "Cognitive Crush",
            date: "15-09-2025",
          ),
        ],
      ),
    );
  }

  Widget _quizCard({
    required Color bgColor,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.stacked_bar_chart,
              color: AppColors.darkblue,
              size: 18,
            ),
            label: const Text(
              "Result",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.darkblue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
