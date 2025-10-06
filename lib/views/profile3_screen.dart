// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart'; // ✅ Import image picker
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/home_screen.dart';

// class ProfileScreen3 extends StatefulWidget {
//   const ProfileScreen3({super.key});

//   @override
//   State<ProfileScreen3> createState() => _ProfileScreen3State();
// }

// class _ProfileScreen3State extends State<ProfileScreen3> {
//   File? _pickedImage; // ✅ To store selected image

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _pickedImage = File(pickedFile.path);
//       });
//     }
//   }

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

//           // 🔹 Bottom Card Container
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
//                     SizedBox(height: h(0.01)),
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
//                     SizedBox(height: h(0.01)),
//                     Text(
//                       "Upload Picture",
//                       style: TextStyle(fontSize: sp(13), color: Colors.grey),
//                     ),
//                     SizedBox(height: h(0.01)),

//                     // 🔹 Flexible middle section
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: _pickImage, // ✅ Open gallery when tapped
//                             child: Container(
//                               width: w(0.35),
//                               height: w(0.35),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: AppColors.greytextfields,
//                                   width: 1.5,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child:
//                                     _pickedImage == null
//                                         ? Icon(
//                                           Icons.person,
//                                           size: sp(60),
//                                           color: Colors.grey,
//                                         ) // ✅ Default icon
//                                         : Image.file(
//                                           _pickedImage!,
//                                           fit: BoxFit.cover,
//                                         ), // ✅ Picked image
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: h(0.015)),
//                           GestureDetector(
//                             onTap: _pickImage, // ✅ Also clickable text
//                             child: Text(
//                               "Upload Your Picture",
//                               style: TextStyle(
//                                 fontSize: sp(14),
//                                 color: Colors.blue, // make it clickable looking
//                                 fontWeight: FontWeight.w600,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: h(0.015)),

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
//                               // TODO: Next screen logic
//                               Get.to(HomeScreen());
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
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/image_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/views/home_screen.dart';

class ProfileScreen3 extends StatefulWidget {
  const ProfileScreen3({super.key});

  @override
  State<ProfileScreen3> createState() => _ProfileScreen3State();
}

class _ProfileScreen3State extends State<ProfileScreen3> {
  File? _pickedImage; // Store selected image
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  // Upload image when Next button is clicked
  Future<void> _uploadImage() async {
    if (_pickedImage == null) return;

    final profileProvider = Provider.of<ProfileImageProvider>(
      context,
      listen: false,
    );
    await profileProvider.addImage(_pickedImage!.path);

    if (profileProvider.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(profileProvider.errorMessage!)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image uploaded successfully!")),
      );
      Get.to(HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2),
              imageUrl: AppImages.profilebg,
            ),
          ),

          // Skip button
          Positioned(
            top: 40,
            right: 10,
            child: GestureDetector(
              onTap: () => Get.to(HomeScreen()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
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
          ),

          // Bottom card
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer<ProfileImageProvider>(
              builder: (context, profileProvider, child) {
                return Container(
                  width: double.infinity,
                  height: screenHeight * 0.43,
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
                        SizedBox(height: h(0.01)),
                        Text(
                          "Complete Your Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: sp(18),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: h(0.01)),
                        Text(
                          "Upload Picture",
                          style: TextStyle(
                            fontSize: sp(13),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: h(0.01)),

                        // Image picker
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: w(0.35),
                                  height: w(0.35),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greytextfields,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child:
                                        profileProvider.isLoading
                                            ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                            : _pickedImage == null
                                            ? Icon(
                                              Icons.person,
                                              size: sp(60),
                                              color: Colors.grey,
                                            )
                                            : Image.file(
                                              _pickedImage!,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                ),
                              ),
                              SizedBox(height: h(0.015)),
                              GestureDetector(
                                onTap: _pickImage,
                                child: Text(
                                  "Upload Your Picture",
                                  style: TextStyle(
                                    fontSize: sp(14),
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: h(0.015)),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(
                                    color: AppColors.greytextfields,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: h(0.018),
                                  ),
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
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(
                                    color: AppColors.greytextfields,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: h(0.018),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: _uploadImage, // Upload image on Next
                                child: Text(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
