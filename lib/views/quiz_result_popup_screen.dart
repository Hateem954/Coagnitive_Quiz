import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/quizzes_screen.dart';

class QuizResultPopupScreen extends StatefulWidget {
  final String category;
  final int totalQuestions;
  final int attempted;
  final int correct;
  final double percentage;
  final String? aiResponse;
  final VoidCallback onClose;

  const QuizResultPopupScreen({
    super.key,
    required this.category,
    required this.totalQuestions,
    required this.attempted,
    required this.correct,
    required this.percentage,
    required this.onClose,
    this.aiResponse,
  });

  @override
  State<QuizResultPopupScreen> createState() => _QuizResultPopupScreenState();
}

class _QuizResultPopupScreenState extends State<QuizResultPopupScreen> {
  bool _showAiResponse = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: 323,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xfffefefe), Color(0xfffef7f7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Image + Close Icon Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  CustomImageContainer(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.2,
                    imageUrl: AppImages.Welcome,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black87,
                      size: 24,
                    ),
                    onPressed: () {
                      Get.to(Quizzes());
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // 🔹 Category Tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xfff5d8d8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.category,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "🎉 Congratulations 🎉",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Result Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildResultRow(
                    "Total Questions",
                    "${widget.totalQuestions}",
                  ),
                  _buildResultRow("Attempted", "${widget.attempted}"),
                  _buildResultRow("Correct", "${widget.correct}"),
                  _buildResultRow(
                    "Percentage",
                    "${widget.percentage.toStringAsFixed(1)}%",
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 🔹 Buttons Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAiResponse = !_showAiResponse;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4c6ef5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        _showAiResponse
                            ? "Hide AI Response"
                            : "View Answersheet",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: widget.onClose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              // 🔹 Expandable AI Response Section
              if (_showAiResponse && widget.aiResponse != null) ...[
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f4ff),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffdce0f0)),
                  ),
                  child: Text(
                    widget.aiResponse!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Helper for result rows
  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
