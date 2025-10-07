// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/forgetpassword_screen.dart';

// class ForgetOtp extends StatefulWidget {
//   final String email;
//   const ForgetOtp({super.key,
//   required this.email});

//   @override
//   State<ForgetOtp> createState() => _ForgetOtpState();
// }

// class _ForgetOtpState extends State<ForgetOtp> {
//   final List<TextEditingController> _controllers = List.generate(
//     4,
//     (index) => TextEditingController(),
//   );
//   final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size; // screen size
//     final width = size.width;
//     final height = size.height;

//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.06),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: height * 0.02),

//               // Back Button
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back_ios, size: 20),
//               ),
//               SizedBox(height: height * 0.01),

//               // Title
//               Text(
//                 "OTP Verification",
//                 style: TextStyle(
//                   fontSize: width * 0.07,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.black,
//                 ),
//               ),
//               SizedBox(height: height * 0.01),

//               // Subtitle
//               Text(
//                 "Enter the verification code we just sent on your email address or phone number.",
//                 style: TextStyle(
//                   fontSize: width * 0.04,
//                   color: AppColors.black,
//                 ),
//               ),
//               SizedBox(height: height * 0.05),

//               // OTP Input Fields
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(
//                   4,
//                   (index) => SizedBox(
//                     width: width * 0.18,
//                     child: TextField(
//                       controller: _controllers[index],
//                       focusNode: _focusNodes[index],
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       maxLength: 1,
//                       style: TextStyle(
//                         fontSize: width * 0.06,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       decoration: InputDecoration(
//                         counterText: "",
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: AppColors.greytextfields,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: AppColors.lightblue,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         filled: true,
//                         fillColor: AppColors.white,
//                       ),
//                       onChanged: (value) {
//                         if (value.isNotEmpty && index < 3) {
//                           FocusScope.of(
//                             context,
//                           ).requestFocus(_focusNodes[index + 1]);
//                         }
//                         if (value.isEmpty && index > 0) {
//                           FocusScope.of(
//                             context,
//                           ).requestFocus(_focusNodes[index - 1]);
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: height * 0.04),

//               // Verify Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF4A5CF6),
//                     padding: EdgeInsets.symmetric(vertical: height * 0.02),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     // Collect OTP
//                     String otp = _controllers.map((c) => c.text).join();
//                     debugPrint("Entered OTP: $otp");

//                     if (otp.length == 4) {
//                       Get.to(() => const ForgetPassword());
//                     }
//                   },
//                   child: Text(
//                     "Verify",
//                     style: TextStyle(
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(),

//               // Resend Text
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Didn’t received code?",
//                       style: TextStyle(
//                         fontSize: width * 0.04,
//                         color: AppColors.black,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Resend OTP
//                       },
//                       child: Text(
//                         "Resend",
//                         style: TextStyle(
//                           fontSize: width * 0.045,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.darkblue,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: height * 0.02),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/forget_otp_verify_controller.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/forgetpassword_screen.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/controller/forget_otp_controller.dart'; // new verify OTP controller

class ForgetOtp extends StatefulWidget {
  final String email;
  const ForgetOtp({super.key, required this.email});

  @override
  State<ForgetOtp> createState() => _ForgetOtpState();
}

class _ForgetOtpState extends State<ForgetOtp> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  // ✅ Initialize controller using GetX
  final verifyController = Get.put(ForgetOtpVerifyController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    String otp = _controllers.map((c) => c.text).join();
    debugPrint("Entered OTP: $otp");

    if (otp.length != 4) {
      Get.snackbar(
        "Invalid OTP",
        "Please enter a valid 4-digit OTP.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return;
    }

    final params = {"email": widget.email, "otp": otp};

    verifyController.verifyForgetOtp(params).then((_) {
      if (verifyController.otpVerifyResponse?.success == true) {
        Get.snackbar(
          "Success",
          "OTP Verified Successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.transparent,
          colorText: AppColors.white,
        );
        // ✅ Navigate to Forget Password Screen
        Get.to(() => ForgetPassword(email: widget.email));
      } else {
        Get.snackbar(
          "Error",
          verifyController.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                // Back Button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                ),
                SizedBox(height: height * 0.01),

                // Title
                Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: height * 0.01),

                // Subtitle
                Text(
                  "Enter the verification code we just sent to your email address.",
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: height * 0.05),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      width: width * 0.18,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.greytextfields,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.lightblue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_focusNodes[index + 1]);
                          }
                          if (value.isEmpty && index > 0) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_focusNodes[index - 1]);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),

                // Verify Button
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
                    onPressed:
                        verifyController.isLoading.value
                            ? null
                            : _verifyOtp, // 🔹 call the function
                    child:
                        verifyController.isLoading.value
                            ? const CircularProgressIndicator(
                              color: AppColors.white,
                            )
                            : Text(
                              "Verify",
                              style: TextStyle(
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                  ),
                ),
                const Spacer(),

                // Resend Text
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn’t receive code?",
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: call resend OTP API
                        },
                        child: Text(
                          "Resend",
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
            );
          }),
        ),
      ),
    );
  }
}
