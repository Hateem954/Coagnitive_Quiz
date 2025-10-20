// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/home_screen.dart';
// import 'package:quiz/views/profile3_screen.dart';

// class ProfileScreen2 extends StatefulWidget {
//   const ProfileScreen2({super.key});

//   @override
//   State<ProfileScreen2> createState() => _ProfileScreen2State();
// }

// class _ProfileScreen2State extends State<ProfileScreen2> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // 🔹 Start with no selection
//   String selectedAge = "";

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value; // % of height
//     double w(double value) => screenWidth * value; // % of width
//     double sp(double value) =>
//         screenWidth * (value / 390); // scale font (390 = base width iPhone 12)

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // 🔹 Top Illustration (background image)
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2),
//               imageUrl: AppImages.profilebg,
//             ),
//           ),

//           Positioned(
//             top: 40,
//             right: 10,
//             child: GestureDetector(
//               onTap: () {
//                 Get.to(HomeScreen());
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   "Skip",
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//             ),
//           ),

//           // 🔹 Bottom Card container
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.43,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.06,
//                   vertical: screenHeight * 0.02,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: screenHeight * 0.01),
//                     Text(
//                       "Complete Your Profile",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: sp(18),
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         letterSpacing: 0.8,
//                       ),
//                     ),
//                     SizedBox(height: h(0.005)),
//                     Text(
//                       "Select Your Age Group",
//                       style: TextStyle(fontSize: sp(13), color: Colors.grey),
//                     ),
//                     SizedBox(height: h(0.03)),

//                     // 🔹 Age Group Options
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ageGroupCard("03-05", "03-05", sp, h, w),
//                         ageGroupCard("05-07", "05-07", sp, h, w),
//                         ageGroupCard("07-09", "07-09", sp, h, w),
//                         ageGroupCard("09-11", "09-11", sp, h, w),
//                       ],
//                     ),

//                     SizedBox(height: h(0.04)),

//                     // 🔹 Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: screenWidth * 0.25,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black,
//                               side: const BorderSide(
//                                 color: AppColors.greytextfields,
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                             ),
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: Text(
//                               "Back",
//                               style: TextStyle(
//                                 fontSize: sp(14),
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: screenWidth * 0.35,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black,
//                               side: const BorderSide(
//                                 color: AppColors.greytextfields,
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (selectedAge.isEmpty) {
//                                 Get.snackbar(
//                                   "Selection Required",
//                                   "Please select an age group before continuing",
//                                   snackPosition: SnackPosition.BOTTOM,
//                                 );
//                               } else {
//                                 // Next logic with selectedAge
//                               }
//                               Get.to(ProfileScreen3());
//                             },
//                             child: Text(
//                               "Next",
//                               style: TextStyle(
//                                 fontSize: sp(14),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Helper Widget for Age Group Card
//   Widget ageGroupCard(
//     String value,
//     String label,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//   ) {
//     final bool isSelected = selectedAge == value;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedAge = value;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.grey.shade200 : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.black : AppColors.greytextfields,
//             width: 1.2,
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: sp(14),
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
// yai code shi chal raha hai k jab mai nay age select kiii hai tb shi hai
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:quiz/provider/age_provider.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/home_screen.dart';
// import 'package:quiz/views/profile3_screen.dart';

// class ProfileScreen2 extends StatefulWidget {
//   const ProfileScreen2({super.key});

//   @override
//   State<ProfileScreen2> createState() => _ProfileScreen2State();
// }

// class _ProfileScreen2State extends State<ProfileScreen2> {
//   String selectedAge = "";

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     final ageProvider = Provider.of<AgeProvider>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // 🔹 Background Image
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2),
//               imageUrl: AppImages.profilebg,
//             ),
//           ),

//           // 🔹 Skip Button
//           Positioned(
//             top: 40,
//             right: 10,
//             child: GestureDetector(
//               onTap: () {
//                 Get.to(HomeScreen());
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   "Skip",
//                   style: TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//               ),
//             ),
//           ),

//           // 🔹 Bottom Container
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.43,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.06,
//                   vertical: screenHeight * 0.02,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: screenHeight * 0.01),
//                     Text(
//                       "Complete Your Profile",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: sp(18),
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         letterSpacing: 0.8,
//                       ),
//                     ),
//                     SizedBox(height: h(0.005)),
//                     Text(
//                       "Select Your Age Group",
//                       style: TextStyle(fontSize: sp(13), color: Colors.grey),
//                     ),
//                     SizedBox(height: h(0.03)),

//                     // 🔹 Age Group Options
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ageGroupCard("03-05", sp, h, w),
//                         ageGroupCard("05-07", sp, h, w),
//                         ageGroupCard("07-09", sp, h, w),
//                         ageGroupCard("09-11", sp, h, w),
//                       ],
//                     ),

//                     SizedBox(height: h(0.04)),

//                     // 🔹 Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: screenWidth * 0.25,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black,
//                               side: const BorderSide(
//                                 color: AppColors.greytextfields,
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                             ),
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: Text(
//                               "Back",
//                               style: TextStyle(
//                                 fontSize: sp(14),
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: screenWidth * 0.35,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black,
//                               side: const BorderSide(
//                                 color: AppColors.greytextfields,
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                             ),
//                             onPressed:
//                                 ageProvider.isLoading
//                                     ? null
//                                     : () async {
//                                       if (selectedAge.isEmpty) {
//                                         Get.snackbar(
//                                           "Error",
//                                           "Please select an age group",
//                                           snackPosition: SnackPosition.BOTTOM,
//                                         );
//                                         return;
//                                       }

//                                       await ageProvider.addAge(
//                                         age: selectedAge,
//                                       );

//                                       if (ageProvider.profile != null) {
//                                         Get.to(ProfileScreen3());
//                                       } else {
//                                         Get.snackbar(
//                                           "Error",
//                                           "Failed to update age",
//                                           snackPosition: SnackPosition.BOTTOM,
//                                         );
//                                       }
//                                     },
//                             child:
//                                 ageProvider.isLoading
//                                     ? const CircularProgressIndicator(
//                                       color: Colors.black,
//                                     )
//                                     : Text(
//                                       "Next",
//                                       style: TextStyle(
//                                         fontSize: sp(14),
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Helper Widget for Age Group Card
//   Widget ageGroupCard(
//     String value,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//   ) {
//     final bool isSelected = selectedAge == value;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedAge = value;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.grey.shade200 : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.black : AppColors.greytextfields,
//             width: 1.2,
//           ),
//         ),
//         child: Text(
//           value,
//           style: TextStyle(
//             fontSize: sp(14),
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz/model/get_age_model.dart';
import 'package:quiz/provider/age_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/home_screen.dart';
import 'package:quiz/views/profile3_screen.dart';

class ProfileScreen2 extends StatefulWidget {
  const ProfileScreen2({super.key});

  @override
  State<ProfileScreen2> createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {
  RangeModel? selectedAgeRange;

  @override
  void initState() {
    super.initState();
    // Fetch age ranges when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AgeProvider>(context, listen: false).fetchAgeRanges();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    final ageProvider = Provider.of<AgeProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2),
              imageUrl: AppImages.profilebg,
            ),
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Get.to(HomeScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: AppColors.black, fontSize: 14),
                ),
              ),
            ),
          ),

          // Bottom Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.43,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h(0.01)),
                    Text(
                      "Complete Your Profile",
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
                      "Select Your Age Group",
                      style: TextStyle(fontSize: sp(13), color: AppColors.grey),
                    ),
                    SizedBox(height: h(0.03)),

                    // Age Group Options
                    Expanded(
                      child:
                          ageProvider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ageProvider.ageRanges.isEmpty
                              ? const Center(child: Text("No age ranges found"))
                              : SingleChildScrollView(
                                child: Wrap(
                                  spacing: w(0.03),
                                  runSpacing: h(0.02),
                                  children:
                                      ageProvider.ageRanges
                                          .map(
                                            (range) =>
                                                ageGroupCard(range, sp, h, w),
                                          )
                                          .toList(),
                                ),
                              ),
                    ),

                    SizedBox(height: h(0.02)),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.25,
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
                            onPressed: () => Get.back(),
                            child: Text(
                              "Back",
                              style: TextStyle(fontSize: sp(14)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.35,
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
                            onPressed:
                                ageProvider.isLoading
                                    ? null
                                    : () async {
                                      if (selectedAgeRange == null) {
                                        Get.snackbar(
                                          "Error",
                                          "Please select an age group",
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                        return;
                                      }

                                      await ageProvider.addAge(
                                        age: selectedAgeRange!.range,
                                      );

                                      if (ageProvider.profile != null) {
                                        Get.to(ProfileScreen3());
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "Failed to update age",
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      }
                                    },
                            child:
                                ageProvider.isLoading
                                    ? const CircularProgressIndicator(
                                      color: AppColors.black,
                                    )
                                    : Text(
                                      "Next",
                                      style: TextStyle(
                                        fontSize: sp(14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        ),
                      ],
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

  // Helper Widget for Age Group Card
  Widget ageGroupCard(
    RangeModel range,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
  ) {
    final bool isSelected = selectedAgeRange?.id == range.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAgeRange = range;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.grey : AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.black : AppColors.greytextfields,
            width: 1.2,
          ),
        ),
        child: Text(
          range.range,
          style: TextStyle(
            fontSize: sp(14),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
