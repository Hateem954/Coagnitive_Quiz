// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/instance_manager.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/welcome2_screen.dart';

// class Welcome3Screen extends StatefulWidget {
//   const Welcome3Screen({super.key});

//   @override
//   State<Welcome3Screen> createState() => _Welcome3ScreenState();
// }

// class _Welcome3ScreenState extends State<Welcome3Screen> {
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE0E0E0), // light gray
//       body: Stack(
//         children: [
//           // 🔹 Skip button on top-right
//           Positioned(
//             top: 40,
//             right: 20,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Text(
//                 "Skip",
//                 style: TextStyle(color: Colors.black, fontSize: 14),
//               ),
//             ),
//           ),

//           Padding(
//             padding: EdgeInsets.only(top: screenHeight * 0.12),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   // 🔹 Background Image slightly upward & shifted LEFT
//                   Transform.translate(
//                     offset: const Offset(
//                       -05,
//                       -70,
//                     ), // x = -10 (left), y = -20 (upward)
//                     child: CustomImageContainer(
//                       height: screenHeight * 0.35,
//                       width: screenWidth * 0.99,
//                       imageUrl: AppImages.backWelcome,
//                     ),
//                   ),

//                   // 🔹 Foreground Image (stay aligned to right)
//                   CustomImageContainer(
//                     height: screenHeight * 0.4,
//                     width: screenWidth * 0.74,
//                     imageUrl: AppImages.Welcome3,
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // 🔹 Bottom popup container
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.42,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(22.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 15),
//                     const Text(
//                       "Test Your Knowledge\n with Quizzo",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       "Compete with friends, earn points, and\n"
//                       "climb the leaderboard in this addictive\n"
//                       "trivia challenge.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 14, color: Colors.black54),
//                     ),
//                     const Spacer(),

//                     // 🔹 Page indicator + Next button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Page indicator
//                         Row(
//                           children: [
//                             Container(
//                               width: 6,
//                               height: 6,
//                               decoration: const BoxDecoration(
//                                 color: AppColors.darkblue,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Container(
//                               width: 6,
//                               height: 6,
//                               decoration: const BoxDecoration(
//                                 color: AppColors.darkblue,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Container(
//                               width: 20,
//                               height: 6,
//                               decoration: BoxDecoration(
//                                 color: AppColors.darkblue,
//                                 borderRadius: BorderRadius.circular(3),
//                               ),
//                             ),
//                           ],
//                         ),

//                         // Next button
//                         // Container(
//                         //   height: 55,
//                         //   width: 55,
//                         //   decoration: const BoxDecoration(
//                         //     color: Colors.blue,
//                         //     shape: BoxShape.circle,
//                         //   ),
//                         //   child: const Icon(
//                         //     Icons.arrow_forward,
//                         //     color: Colors.white,
//                         //     size: 26,
//                         //   ),
//                         // ),
//                         GestureDetector(
//                           onTap: () {
//                             // 👇 Your onPressed action here
//                             Get.to(Welcome2Screen());
//                             // Example: Navigator.push(context, MaterialPageRoute(builder: (_) => NextScreen()));
//                           },
//                           child: Container(
//                             height: 55,
//                             width: 55,
//                             decoration: const BoxDecoration(
//                               color: AppColors.darkblue,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.arrow_forward,
//                               color: Colors.white,
//                               size: 26,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/sign_inscreeen.dart';

class Welcome3Screen extends StatefulWidget {
  const Welcome3Screen({super.key});

  @override
  State<Welcome3Screen> createState() => _Welcome3ScreenState();
}

class _Welcome3ScreenState extends State<Welcome3Screen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value; // % of height
    double w(double value) => screenWidth * value; // % of width
    double sp(double value) =>
        screenWidth * (value / 390); // scale font (390 = base width iPhone 12)
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // light gray
      body: Stack(
        children: [
          // 🔹 Skip button
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),

          // 🔹 Images
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.12),
            child: Align(
              alignment: Alignment.topRight,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  // Background (shifted left & upward)
                  Transform.translate(
                    offset: const Offset(-12, -20), // left + upward
                    child: SizedBox(
                      height: screenHeight,
                      width: screenWidth,
                      child: CustomImageContainer(
                        height: h(0.34),
                        width: w(3),
                        imageUrl: AppImages.backWelcome,
                      ),
                    ),
                  ),

                  // 🔹 Foreground Image
                  SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: CustomImageContainer(
                      height: h(0.45),
                      width: w(1.05),
                      imageUrl: AppImages.Welcome3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Bottom popup
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.42,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Test Your Knowledge\n with Quizzo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Compete with friends, earn points, and\n"
                      "climb the leaderboard in this addictive\n"
                      "trivia challenge.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Spacer(),

                    // 🔹 Page indicator + Next button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page indicator (third step active)
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.darkblue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.darkblue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 20,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.darkblue,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),

                        // 🔹 Next button with arc
                        GestureDetector(
                          onTap: () {
                            // 👉 Navigate to Login/Home here
                            // Example:
                            // Get.to(const LoginScreen());
                            Get.to(Login());
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00008B), // Dark Blue
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons
                                      .arrow_forward, // final screen uses check
                                  color: Colors.white,
                                  size: 26,
                                ),
                                Positioned.fill(
                                  child: CustomPaint(painter: ArcPainter()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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

/// 🎨 Arc painter (same as Welcome2Screen)
class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColors.darkblue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    // 🔹 Add spacing by reducing radius a bit
    final double spacing = 5; // adjust gap here
    final Rect rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: (size.width / 2) + spacing, // arc slightly outside the button
    );

    // Draw arc with start & sweep angle
    canvas.drawArc(rect, 4.5, 8, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
