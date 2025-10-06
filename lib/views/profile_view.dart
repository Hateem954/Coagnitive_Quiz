// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/profile3_screen.dart';

// class ViewProfile extends StatefulWidget {
//   const ViewProfile({super.key});

//   @override
//   State<ViewProfile> createState() => _ViewProfileState();
// }

// class _ViewProfileState extends State<ViewProfile> {
//   // 🔹 Start with no selection
//   String selectedAge = "";

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // 🔹 Background Illustration
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2),
//               imageUrl: AppImages.editbg,
//             ),
//           ),

//           // 🔹 Bottom Card
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.55,
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
//                     SizedBox(height: h(0.02)),

//                     // 🔹 Profile Avatar
//                     CircleAvatar(
//                       radius: sp(35),
//                       backgroundImage: const NetworkImage(
//                         "https://i.pravatar.cc/150?img=3",
//                       ),
//                     ),
//                     SizedBox(height: h(0.015)),

//                     // 🔹 User Name
//                     Text(
//                       "User One",
//                       style: TextStyle(
//                         fontSize: sp(16),
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: h(0.03)),

//                     // 🔹 Phone Number
//                     profileInfoRow(Icons.phone, "+92 333 1234567", sp, h, w),

//                     SizedBox(height: h(0.015)),

//                     // 🔹 Gender
//                     profileInfoRow(Icons.wc, "Female", sp, h, w),

//                     SizedBox(height: h(0.015)),

//                     // 🔹 Age Group
//                     profileInfoRow(Icons.hourglass_bottom, "05-07", sp, h, w),

//                     SizedBox(height: h(0.04)),

//                     // 🔹 Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: screenWidth * 0.35,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.black,
//                               side: const BorderSide(color: Colors.grey),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {
//                               // edit details
//                             },
//                             child: Text(
//                               "Edit Details",
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
//                               side: const BorderSide(color: Colors.grey),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: () {
//                               // logout logic
//                             },
//                             child: Text(
//                               "Logout",
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

//   Widget profileInfoRow(
//     IconData icon,
//     String text,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//   ) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.blue, size: sp(18)),
//           SizedBox(width: w(0.04)),
//           Text(text, style: TextStyle(fontSize: sp(14), color: Colors.black)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ Required for Get.to()
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/home_screen.dart'; // ✅ Make sure HomeScreen is imported

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool isEditing = false; // ✅ Toggle between view & edit mode

  // Controllers for editable fields
  final TextEditingController phoneController = TextEditingController(
    text: "+92 333 1234567",
  );
  final TextEditingController genderController = TextEditingController(
    text: "Female",
  );
  final TextEditingController ageController = TextEditingController(
    text: "05-07",
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Background Illustration
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2.2),
              imageUrl: AppImages.editbg,
            ),
          ),

          // 🔹 Back Arrow Button (Top Left)
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Get.to(const HomeScreen()); // ✅ Navigate back to HomeScreen
              },
              child: Container(
                padding: const EdgeInsets.all(8),

                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          // 🔹 Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
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
                    SizedBox(height: h(0.02)),

                    // 🔹 Profile Image in Box
                    Container(
                      width: w(0.25),
                      height: w(0.25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://i.pravatar.cc/150?img=3",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: h(0.03)),

                    // 🔹 Phone
                    profileInfoRow(
                      Icons.phone,
                      "Phone",
                      phoneController,
                      sp,
                      h,
                      w,
                    ),
                    SizedBox(height: h(0.015)),

                    // 🔹 Gender
                    profileInfoRow(
                      Icons.wc,
                      "Gender",
                      genderController,
                      sp,
                      h,
                      w,
                    ),
                    SizedBox(height: h(0.015)),

                    // 🔹 Age
                    profileInfoRow(
                      Icons.hourglass_bottom,
                      "Age Group",
                      ageController,
                      sp,
                      h,
                      w,
                    ),
                    SizedBox(height: h(0.04)),

                    // 🔹 Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isEditing = !isEditing; // toggle edit mode
                              });
                            },
                            child: Text(
                              isEditing ? "Save" : "Edit Details",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              // logout logic
                            },
                            child: Text(
                              "Logout",
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

  // 🔹 Profile Row Helper
  Widget profileInfoRow(
    IconData icon,
    String label,
    TextEditingController controller,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: sp(22)),
          SizedBox(width: w(0.04)),
          Expanded(
            child:
                isEditing
                    ? TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(fontSize: sp(14), color: Colors.black),
                    )
                    : Text(
                      controller.text,
                      style: TextStyle(fontSize: sp(14), color: Colors.black),
                    ),
          ),
        ],
      ),
    );
  }
}
