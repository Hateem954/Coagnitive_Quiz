// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/forgetverify_screen.dart';

// class ForgetPassword extends StatefulWidget {
//   final String email;
//   const ForgetPassword({super.key, required this.email});

//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }

// class _ForgetPasswordState extends State<ForgetPassword> {
//   bool _isObscureNew = true;
//   bool _isObscureConfirm = true;

//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
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
//                 "Create New Password",
//                 style: TextStyle(
//                   fontSize: width * 0.07,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.black,
//                 ),
//               ),
//               SizedBox(height: height * 0.01),

//               // Subtitle
//               Text(
//                 "Your new password must be unique from those previously used.",
//                 style: TextStyle(
//                   fontSize: width * 0.04,
//                   color: AppColors.black,
//                 ),
//               ),
//               SizedBox(height: height * 0.05),

//               // New Password Field
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: TextField(
//                   controller: _newPasswordController,
//                   obscureText: _isObscureNew,
//                   decoration: InputDecoration(
//                     hintText: "New Password",
//                     hintStyle: const TextStyle(
//                       color: AppColors.black,
//                       fontSize: 14,
//                     ),
//                     filled: true,
//                     fillColor: AppColors.white,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscureNew ? Icons.visibility_off : Icons.visibility,
//                         color: AppColors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isObscureNew = !_isObscureNew;
//                         });
//                       },
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: AppColors.greytextfields,
//                         width: 1,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: Colors.black45,
//                         width: 1.2,
//                       ),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 14,
//                       horizontal: 12,
//                     ),
//                   ),
//                   style: const TextStyle(fontSize: 16, color: AppColors.black),
//                 ),
//               ),

//               // Confirm Password Field
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: TextField(
//                   controller: _confirmPasswordController,
//                   obscureText: _isObscureConfirm,
//                   decoration: InputDecoration(
//                     hintText: "Confirm Password",
//                     hintStyle: const TextStyle(
//                       color: AppColors.black,
//                       fontSize: 14,
//                     ),
//                     filled: true,
//                     fillColor: AppColors.white,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscureConfirm
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: AppColors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isObscureConfirm = !_isObscureConfirm;
//                         });
//                       },
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: AppColors.greytextfields,
//                         width: 1,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         color: Colors.black45,
//                         width: 1.2,
//                       ),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 14,
//                       horizontal: 12,
//                     ),
//                   ),
//                   style: const TextStyle(fontSize: 16, color: AppColors.black),
//                 ),
//               ),

//               SizedBox(height: height * 0.04),

//               // Reset Password Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.lightblue,
//                     padding: EdgeInsets.symmetric(vertical: height * 0.02),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     // Add reset password logic
//                     Get.to(ForgetVerifyPassword());
//                   },
//                   child: Text(
//                     "Reset Password",
//                     style: TextStyle(
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/controller/forget_password_update_controller.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/forgetverify_screen.dart';

class ForgetPassword extends StatefulWidget {
  final String email;
  const ForgetPassword({super.key, required this.email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ForgetPasswordUpdateController _controller = Get.put(
    ForgetPasswordUpdateController(),
  );

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
            return Stack(
              children: [
                Column(
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
                      "Create New Password",
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.01),

                    // Subtitle
                    Text(
                      "Your new password must be unique from those previously used.",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.05),

                    // New Password Field
                    _buildPasswordField(
                      controller: _newPasswordController,
                      label: "New Password",
                      isObscure: _isObscureNew,
                      toggleVisibility: () {
                        setState(() {
                          _isObscureNew = !_isObscureNew;
                        });
                      },
                    ),

                    // Confirm Password Field
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: "Confirm Password",
                      isObscure: _isObscureConfirm,
                      toggleVisibility: () {
                        setState(() {
                          _isObscureConfirm = !_isObscureConfirm;
                        });
                      },
                    ),

                    SizedBox(height: height * 0.04),

                    // Reset Password Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightblue,
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed:
                            _controller.isLoading.value
                                ? null
                                : () async {
                                  String newPass = _newPasswordController.text;
                                  String confirmPass =
                                      _confirmPasswordController.text;

                                  if (newPass.isEmpty || confirmPass.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Please fill all password fields",
                                      backgroundColor: AppColors.transparent,
                                    );
                                    return;
                                  }
                                  if (newPass != confirmPass) {
                                    Get.snackbar(
                                      "Error",
                                      "Passwords do not match. Try again.",
                                      backgroundColor: AppColors.transparent,
                                    );
                                    return;
                                  }

                                  await _controller.updatePassword({
                                    "email": widget.email,
                                    "password": newPass,
                                    "password_confirmation": confirmPass,
                                  });

                                  if (_controller.updateResponse.value !=
                                          null &&
                                      _controller
                                          .updateResponse
                                          .value!
                                          .success) {
                                    Get.snackbar(
                                      "Success",
                                      _controller.updateResponse.value!.message,
                                      backgroundColor: AppColors.transparent,
                                    );

                                    // ✅ Navigate to Verify Screen
                                    Get.off(() => ForgetVerifyPassword());
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      _controller.errorMessage.value.isNotEmpty
                                          ? _controller.errorMessage.value
                                          : "Failed to update password",
                                      backgroundColor: AppColors.transparent,
                                    );
                                  }
                                },
                        child:
                            _controller.isLoading.value
                                ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                                : Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// 🔹 Reusable Password TextField Builder
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isObscure,
    required VoidCallback toggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: AppColors.black, fontSize: 14),
          filled: true,
          fillColor: AppColors.white,
          suffixIcon: IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: AppColors.grey,
            ),
            onPressed: toggleVisibility,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.greytextfields,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.black, width: 1.2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: AppColors.black),
      ),
    );
  }
}
