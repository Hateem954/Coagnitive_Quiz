import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/welcome1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to HomePage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Get.to(const Welcome1Screen());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width & height from MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.grey, // Gray background
      body: Center(
        child: CustomImageContainer(
          height: screenHeight * 0.26, // 30% of screen height
          width: screenWidth * 0.84, // 60% of screen width
          imageUrl: AppImages.logo,
        ),
      ),
    );
  }
}
