import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/forgetotp_screen.dart';

class ForgetEmail extends StatelessWidget {
  const ForgetEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // screen size for responsiveness
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06, // responsive horizontal padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),

              // Back Button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              SizedBox(height: height * 0.01),

              // Title
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: width * 0.07, // responsive font size
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: height * 0.01),

              // Subtitle
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: height * 0.04),

              // Input Field
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your email and Phone no.",
                  hintStyle: TextStyle(fontSize: width * 0.04),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                    horizontal: width * 0.04,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // Send Code Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightblue,
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Add your logic
                    Get.to(ForgetOtp());
                  },
                  child: Text(
                    "Send Code",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),

              // Remember Password + Login Now
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember Password?",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: AppColors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Login
                      },
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkblue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
