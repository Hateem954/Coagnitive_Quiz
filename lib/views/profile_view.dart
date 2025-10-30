// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import 'package:quiz/api_Services/app_url.dart';
// import 'package:quiz/provider/login_provider.dart';
// import 'package:quiz/provider/profile_update_provider.dart';
// import 'package:quiz/provider/profile_provider.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/guardian_screen.dart';
// import 'package:quiz/views/home_screen.dart';

// class ViewProfile extends StatefulWidget {
//   const ViewProfile({super.key});

//   @override
//   State<ViewProfile> createState() => _ViewProfileState();
// }

// class _ViewProfileState extends State<ViewProfile> {
//   bool isEditing = false;

//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final updateProvider = Provider.of<ProfileUpdateProvider>(context);
//     final profile = profileProvider.profile;

//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     double h(double v) => screenHeight * v;
//     double w(double v) => screenWidth * v;
//     double sp(double v) => screenWidth * (v / 390);

//     // Populate fields when not editing and data available
//     if (profile != null && !isEditing) {
//       phoneController.text = profile.emergencyContact;
//       genderController.text = profile.gender;
//       ageController.text = profile.age;
//     }

//     final isProfileNotFound =
//         profileProvider.errorMessage != null &&
//         profileProvider.errorMessage!.contains("Profile not found");

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           /// 🔹 Background
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2.2),
//               imageUrl: AppImages.editbg,
//             ),
//           ),

//           /// 🔹 Back Arrow
//           Positioned(
//             top: 40,
//             left: 10,
//             child: GestureDetector(
//               onTap: () => Get.to(const HomeScreen()),
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: AppColors.white,
//                 size: 22,
//               ),
//             ),
//           ),

//           /// 🔹 Main Card
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.55,
//               decoration: const BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.black,
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w(0.06),
//                   vertical: h(0.02),
//                 ),
//                 child:
//                     profileProvider.isLoading || updateProvider.isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : isProfileNotFound
//                         ? _buildProfileNotFoundUI(context, sp, h, w)
//                         : profile == null
//                         ? Center(
//                           child: Text(
//                             profileProvider.errorMessage ??
//                                 "No profile data available",
//                             style: const TextStyle(color: AppColors.black),
//                           ),
//                         )
//                         : _buildProfileUI(
//                           context,
//                           profileProvider,
//                           updateProvider,
//                           profile,
//                           sp,
//                           h,
//                           w,
//                           screenWidth,
//                         ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 UI for existing profile
//   Widget _buildProfileUI(
//     BuildContext context,
//     ProfileProvider profileProvider,
//     ProfileUpdateProvider updateProvider,
//     dynamic profile,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//     double screenWidth,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: h(0.02)),

//         /// 🔹 Profile Image
//         Container(
//           width: w(0.25),
//           height: w(0.25),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: AppColors.grey, width: 1),

//             // image: DecorationImage(
//             //   image: NetworkImage(
//             //     profile.image.isNotEmpty
//             //         ? profile.image
//             //         : "https://i.pravatar.cc/150?img=3",
//             //   ),
//             //   fit: BoxFit.cover,
//             // ),
//             image: DecorationImage(
//               image: NetworkImage(
//                 (profile.image.isNotEmpty)
//                     ? (profile.image.startsWith("http")
//                         ? profile.image
//                         : "${AppUrl.imageBaseUrl}${profile.image.startsWith('/') ? '' : '/'}${profile.image}")
//                     : "https://i.pravatar.cc/150?img=3",
//               ),
//               fit: BoxFit.cover,
//               onError: (_, __) => debugPrint("⚠️ Failed to load profile image"),
//             ),
//           ),
//         ),

//         SizedBox(height: h(0.03)),

//         /// 🔹 Editable Info Fields
//         profileInfoRow(Icons.phone, "Phone", phoneController, sp, h, w),
//         SizedBox(height: h(0.015)),
//         profileInfoRow(Icons.wc, "Gender", genderController, sp, h, w),
//         SizedBox(height: h(0.015)),
//         profileInfoRow(
//           Icons.hourglass_bottom,
//           "Age Group",
//           ageController,
//           sp,
//           h,
//           w,
//         ),
//         SizedBox(height: h(0.04)),

//         /// 🔹 Buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             SizedBox(
//               width: screenWidth * 0.35,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.white,
//                   foregroundColor: AppColors.black,
//                   side: const BorderSide(color: AppColors.greytextfields),
//                   padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 onPressed: () async {
//                   if (isEditing) {
//                     await updateProvider.updateProfile(
//                       fEmergencyContact: phoneController.text.trim(),
//                       sGender: genderController.text.trim(),
//                       sAge: ageController.text.trim(),
//                       sLevel: profile.level,
//                     );

//                     if (updateProvider.profileResponse != null &&
//                         updateProvider.profileResponse!.success) {
//                       Get.snackbar(
//                         "Success",
//                         "Profile updated successfully",
//                         backgroundColor: AppColors.transparent,
//                         colorText: AppColors.black,
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                       await Provider.of<ProfileProvider>(
//                         context,
//                         listen: false,
//                       ).fetchProfile();
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             updateProvider.errorMessage ??
//                                 "Failed to update profile.",
//                           ),
//                         ),
//                       );
//                     }
//                   }

//                   setState(() {
//                     isEditing = !isEditing;
//                   });
//                 },
//                 child: Text(
//                   isEditing ? "Save" : "Edit Details",
//                   style: TextStyle(fontSize: sp(14)),
//                 ),
//               ),
//             ),
//             _logoutButton(screenWidth, h, sp),
//           ],
//         ),
//       ],
//     );
//   }

//   /// 🔹 UI for "Profile Not Found"
//   Widget _buildProfileNotFoundUI(
//     BuildContext context,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//   ) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Icon(Icons.error_outline, color: Colors.red, size: 50),
//         SizedBox(height: h(0.02)),
//         const Text(
//           "Profile not found.\nPlease create one.",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: AppColors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: h(0.04)),

//         /// 🔹 Buttons: Create Profile + Logout
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             SizedBox(
//               width: screenWidth * 0.35,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.white,
//                   foregroundColor: AppColors.black,
//                   side: const BorderSide(color: AppColors.greytextfields),
//                   padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//                 onPressed: () {
//                   // ✅ Navigate to create profile screen
//                   Get.to(GuardianInfoScreen());
//                 },
//                 child: Text(
//                   "Create Profile",
//                   style: TextStyle(
//                     fontSize: sp(14),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             _logoutButton(screenWidth, h, sp),
//           ],
//         ),
//       ],
//     );
//   }

//   /// 🔹 Reusable logout button
//   Widget _logoutButton(
//     double screenWidth,
//     double Function(double) h,
//     double Function(double) sp,
//   ) {
//     return SizedBox(
//       width: screenWidth * 0.35,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.white,
//           foregroundColor: AppColors.black,
//           side: const BorderSide(color: AppColors.greytextfields),
//           padding: EdgeInsets.symmetric(vertical: h(0.018)),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//         ),
//         onPressed: () {
//           Provider.of<LoginProvider>(context, listen: false).logout();
//         },
//         child: Text(
//           "Logout",
//           style: TextStyle(fontSize: sp(14), fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   /// 🔹 Reusable Input Row
//   Widget profileInfoRow(
//     IconData icon,
//     String label,
//     TextEditingController controller,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//   ) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.grey, width: 1),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: AppColors.lightblue, size: sp(22)),
//           SizedBox(width: w(0.04)),
//           Expanded(
//             child:
//                 isEditing
//                     ? TextField(
//                       controller: controller,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         isDense: true,
//                         contentPadding: EdgeInsets.zero,
//                       ),
//                       style: TextStyle(
//                         fontSize: sp(14),
//                         color: AppColors.black,
//                       ),
//                     )
//                     : Text(
//                       controller.text.isNotEmpty
//                           ? controller.text
//                           : "Not provided",
//                       style: TextStyle(
//                         fontSize: sp(14),
//                         color: AppColors.black,
//                       ),
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/provider/login_provider.dart';
import 'package:quiz/provider/profile_update_provider.dart';
import 'package:quiz/provider/profile_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/guardian_screen.dart';
import 'package:quiz/views/home_screen.dart';
import 'package:quiz/views/profile3_screen.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool isEditing = false;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final updateProvider = Provider.of<ProfileUpdateProvider>(context);
    final profile = profileProvider.profile;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double h(double v) => screenHeight * v;
    double w(double v) => screenWidth * v;
    double sp(double v) => screenWidth * (v / 390);

    // Populate fields when not editing
    if (profile != null && !isEditing) {
      phoneController.text = profile.emergencyContact;
      genderController.text = profile.gender;
      ageController.text = profile.age;
    }

    final isProfileNotFound =
        profileProvider.errorMessage != null &&
        profileProvider.errorMessage!.contains("Profile not found");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// 🔹 Back Button
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () => Get.to(const HomeScreen()),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 26,
              ),
            ),
          ),

          /// 🔹 User Image (Displayed in a Box)
          Positioned(
            top: h(0.10),
            child: Container(
              width: w(0.45),
              height: w(0.45),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.grey, width: 1),
                image: DecorationImage(
                  image:
                      profile != null && profile.image.isNotEmpty
                          ? NetworkImage(
                            profile.image.startsWith("http")
                                ? profile.image
                                : "${AppUrl.imageBaseUrl}${profile.image.startsWith('/') ? '' : '/'}${profile.image}",
                          )
                          : const NetworkImage(
                            "https://i.pravatar.cc/150?img=3",
                          ),
                  fit: BoxFit.cover,
                  onError:
                      (_, __) => debugPrint("⚠️ Failed to load profile image"),
                ),
              ),
            ),
          ),

          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // 👇 Your onPressed action here
                // Example: Navigate to Login/Home screen
                // Get.to(const LoginScreen());
                Get.to(ProfileScreen3());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Update Image ",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),

          /// 🔹 Main Profile Info Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.60,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
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
                child:
                    profileProvider.isLoading || updateProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : isProfileNotFound
                        ? _buildProfileNotFoundUI(context, sp, h, w)
                        : profile == null
                        ? Center(
                          child: Text(
                            profileProvider.errorMessage ??
                                "No profile data available",
                            style: const TextStyle(color: AppColors.black),
                          ),
                        )
                        : _buildProfileUI(
                          context,
                          profileProvider,
                          updateProvider,
                          profile,
                          sp,
                          h,
                          w,
                          screenWidth,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Profile Details UI
  Widget _buildProfileUI(
    BuildContext context,
    ProfileProvider profileProvider,
    ProfileUpdateProvider updateProvider,
    dynamic profile,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h(0.09)),

        /// 🔹 Editable Info Fields
        profileInfoRow(Icons.phone, "Phone", phoneController, sp, h, w),
        SizedBox(height: h(0.015)),
        profileInfoRow(Icons.wc, "Gender", genderController, sp, h, w),
        SizedBox(height: h(0.015)),
        profileInfoRow(
          Icons.hourglass_bottom,
          "Age Group",
          ageController,
          sp,
          h,
          w,
        ),
        SizedBox(height: h(0.099)),

        /// 🔹 Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: screenWidth * 0.35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.black,
                  side: const BorderSide(color: AppColors.greytextfields),
                  padding: EdgeInsets.symmetric(vertical: h(0.018)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () async {
                  if (isEditing) {
                    await updateProvider.updateProfile(
                      fEmergencyContact: phoneController.text.trim(),
                      sGender: genderController.text.trim(),
                      sAge: ageController.text.trim(),
                      sLevel: profile.level,
                    );

                    if (updateProvider.profileResponse != null &&
                        updateProvider.profileResponse!.success) {
                      Get.snackbar(
                        "Success",
                        "Profile updated successfully",
                        backgroundColor: AppColors.transparent,
                        colorText: AppColors.black,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      await Provider.of<ProfileProvider>(
                        context,
                        listen: false,
                      ).fetchProfile();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            updateProvider.errorMessage ??
                                "Failed to update profile.",
                          ),
                        ),
                      );
                    }
                  }

                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(
                  isEditing ? "Save" : "Edit Details",
                  style: TextStyle(fontSize: sp(14)),
                ),
              ),
            ),
            _logoutButton(screenWidth, h, sp),
          ],
        ),
      ],
    );
  }

  /// 🔹 Profile Not Found UI
  Widget _buildProfileNotFoundUI(
    BuildContext context,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 50),
        SizedBox(height: h(0.02)),
        const Text(
          "Profile not found.\nPlease create one.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: h(0.04)),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: screenWidth * 0.35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.black,
                  side: const BorderSide(color: AppColors.greytextfields),
                  padding: EdgeInsets.symmetric(vertical: h(0.018)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () => Get.to(GuardianInfoScreen()),
                child: Text(
                  "Create Profile",
                  style: TextStyle(
                    fontSize: sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _logoutButton(screenWidth, h, sp),
          ],
        ),
      ],
    );
  }

  /// 🔹 Logout Button
  Widget _logoutButton(
    double screenWidth,
    double Function(double) h,
    double Function(double) sp,
  ) {
    return SizedBox(
      width: screenWidth * 0.35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          side: const BorderSide(color: AppColors.greytextfields),
          padding: EdgeInsets.symmetric(vertical: h(0.018)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          Provider.of<LoginProvider>(context, listen: false).logout();
        },
        child: Text(
          "Logout",
          style: TextStyle(fontSize: sp(14), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// 🔹 Info Row Widget
  Widget profileInfoRow(
    IconData icon,
    String label,
    TextEditingController controller,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.021)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightblue, size: sp(22)),
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
                      style: TextStyle(
                        fontSize: sp(14),
                        color: AppColors.black,
                      ),
                    )
                    : Text(
                      controller.text.isNotEmpty
                          ? controller.text
                          : "Not provided",
                      style: TextStyle(
                        fontSize: sp(14),
                        color: AppColors.black,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
