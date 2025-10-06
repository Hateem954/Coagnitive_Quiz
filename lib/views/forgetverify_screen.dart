import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:quiz/views/sign_inscreeen.dart';

class ForgetVerifyPassword extends StatelessWidget {
  const ForgetVerifyPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Success Icon
              Container(
                padding: EdgeInsets.all(width * 0.08),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: width * 0.15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height * 0.04),

              // ✅ Title
              Text(
                "Password Changed!",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.015),

              // ✅ Subtitle
              Text(
                "Your password has been changed successfully.",
                style: TextStyle(fontSize: width * 0.04, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.06),

              // ✅ Back to Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5CF6),
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.to(Login()); // 👈 Back to login screen
                  },
                  child: Text(
                    "Back to Login",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
