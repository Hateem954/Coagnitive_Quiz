import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/login_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/customtextfields.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/basic_info.dart';
import 'package:quiz/views/forgetemail_screen.dart';
import 'package:quiz/views/guardian_screen.dart';
import 'package:quiz/views/otp_screen.dart';
import 'package:quiz/views/profile1_screen.dart';
import 'package:quiz/views/profile2_screen.dart';
import 'package:quiz/views/signup_screen.dart';
import 'package:quiz/views/welcome2_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 🔹 Responsive helpers
    double h(double value) => screenHeight * value; // % of height
    double w(double value) => screenWidth * value; // % of width
    double sp(double value) =>
        screenWidth * (value / 390); // scale font (390 = base width iPhone 12)

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 🔹 Top Illustration
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2),
              imageUrl: AppImages.loginbg,
            ),
          ),

          // 🔹 Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: h(0.48),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(0.06),
                  vertical: h(0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h(0.01)),
                    Text(
                      "WELCOME TO COGNITIVE \nCOMPASS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sp(18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: h(0.005)),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: sp(13),
                        color: AppColors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: h(0.02)),

                    // Email field
                    buildCustomTextField("Enter Email", emailController),
                    SizedBox(height: screenHeight * 0.019),

                    // Password field
                    buildCustomTextField(
                      "Enter Password",
                      passwordController,
                      obscure: true,
                    ),

                    // 🔹 Forget password aligned right
                    SizedBox(height: h(0.01)),

                    // 🔹 Buttons
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.27,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              // Sign up logic
                              Get.to(SignUpScreen());
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: w(0.06)),
                        SizedBox(
                          width: screenWidth * 0.55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () async {
                              final loginProvider = Provider.of<LoginProvider>(
                                context,
                                listen: false,
                              );

                              try {
                                await loginProvider.login(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );

                                if (loginProvider.loginResponse != null ||
                                    loginProvider.loginResponse!.success) {
                                  // ✅ Navigate if login successful
                                  Get.to(GuardianInfoScreen());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Login failed. Please try again.",
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {}
                            },

                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h(0.015)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Forget password logic
                          Get.to(ForgetEmail());
                        },
                        child: Text(
                          "Forget password ?",
                          style: TextStyle(
                            fontSize: sp(13),
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
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
