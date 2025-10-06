// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/profile_view.dart';
// import 'package:quiz/views/quizzes_screen.dart';
// import 'package:quiz/views/video_screen.dart';
// import 'package:quiz/views/your_quezzesscreen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     // 👇 Pages for bottom nav
//     final List<Widget> pages = [
//       _homePage(h, w, sp), // home page
//       // YourQuizzes(),
//       Quizzes(),
//       VideoScreen(),
//       const Center(child: Text("Advice Page")),
//     ];

//     return Scaffold(
//       resizeToAvoidBottomInset: false, // ✅ Fix overflow
//       backgroundColor: Colors.white,
//       body: SafeArea(child: pages[_selectedIndex]),

//       // 🔹 Floating Action Button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.snackbar("Action", "Create new quiz tapped");
//         },
//         backgroundColor: AppColors.darkblue,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       // 🔹 Bottom Navigation Bar
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: SizedBox(
//           height: 60, // ✅ fixed height to avoid overflow
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: w(0.001)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _bottomNavItem(Icons.home, "Home", 0),
//                 _bottomNavItem(Icons.quiz, "Quizzes", 1),
//                 SizedBox(width: w(0.1)), // space for FAB
//                 _bottomNavItem(Icons.bar_chart, "Videos", 2),
//                 _bottomNavItem(Icons.lightbulb, "Advice", 3),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🔹 Home Page Content
//   Widget _homePage(
//     double Function(double) h,
//     double Function(double) w,
//     double Function(double) sp,
//   ) {
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: w(0.05), vertical: h(0.02)),
//       children: [
//         // Header
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min, // ✅ Fix overflow
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "GOOD MORNING",
//                   style: TextStyle(
//                     fontSize: sp(12),
//                     fontWeight: FontWeight.w500,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//                 SizedBox(height: h(0.004)),
//                 Text(
//                   "Bibhu Dash",
//                   style: TextStyle(
//                     fontSize: sp(18),
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Get.snackbar("Profile", "Go to Profile Screen");
//                 Get.to(ViewProfile());
//               },
//               child: CircleAvatar(
//                 radius: 22,
//                 backgroundColor: Colors.grey.shade200,
//                 child: const Icon(Icons.person, size: 26, color: Colors.black),
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: h(0.025)),

//         // Quizzes Row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Quizzes",
//               style: TextStyle(fontSize: sp(16), fontWeight: FontWeight.bold),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: w(0.03),
//                 vertical: h(0.006),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 "35+",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: sp(13),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: h(0.015)),

//         // Featured Quiz Card
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(w(0.04)),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             gradient: const LinearGradient(
//               colors: [Colors.redAccent, Colors.blueAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Category + Time
//               Row(
//                 children: [
//                   _chip("Psychology", Colors.red),
//                   SizedBox(width: w(0.02)),
//                   _chip("3 min", Colors.black87),
//                   const Spacer(),
//                   const Icon(Icons.close, color: Colors.white),
//                 ],
//               ),
//               SizedBox(height: h(0.015)),
//               Text(
//                 "Personality Check",
//                 style: TextStyle(
//                   fontSize: sp(18),
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: h(0.005)),
//               Text(
//                 "10 Quizzes",
//                 style: TextStyle(fontSize: sp(13), color: Colors.white70),
//               ),
//               SizedBox(height: h(0.015)),
//               Row(
//                 children: [
//                   const CircleAvatar(
//                     radius: 16,
//                     backgroundImage: NetworkImage(
//                       "https://i.pravatar.cc/150?img=5",
//                     ),
//                   ),
//                   SizedBox(width: w(0.02)),
//                   Text(
//                     "Creator\nDr. Demo",
//                     style: TextStyle(fontSize: sp(12), color: Colors.white),
//                   ),
//                   const Spacer(),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       "Start Now",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: sp(13),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),

//         SizedBox(height: h(0.03)),

//         // Your Quizzes Section
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Your Quizzes",
//               style: TextStyle(fontSize: sp(15), fontWeight: FontWeight.bold),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Get.to(YourQuizzes());
//               },
//               child: Text(
//                 "See all",
//                 style: TextStyle(
//                   fontSize: sp(15),
//                   fontWeight: FontWeight.w500,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: h(0.015)),

//         // Quizzes List
//         _quizItem("Stress Checker", "20-09-2025"),
//         _quizItem("General Knowledge", "18-09-2025"),
//         _quizItem("Statistic Quiz", "12-09-2025"),
//       ],
//     );
//   }

//   /// 🔹 Chip Widget
//   Widget _chip(String label, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 11,
//           color: textColor,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   /// 🔹 Quiz Item
//   Widget _quizItem(String title, String date) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 date,
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//               ),
//             ],
//           ),
//           Text(
//             "Result",
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 Bottom Nav Item
//   Widget _bottomNavItem(IconData icon, String label, int index) {
//     final bool isActive = _selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: isActive ? AppColors.darkblue : Colors.transparent,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: isActive ? Colors.white : Colors.grey,
//                 size: 22,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isActive ? AppColors.darkblue : Colors.grey,
//                 fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// is may saara ook hai sirf user name dinamic show hoo raha hai
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/Controller/category_controller.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/profile_view.dart';
// import 'package:quiz/views/quizzes_screen.dart';
// import 'package:quiz/views/video_screen.dart';
// import 'package:quiz/views/videotraining_screeen.dart';
// import 'package:quiz/views/your_quezzesscreen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   final CategoryController categoryController = Get.put(CategoryController());

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     // 👇 Pages for bottom nav
//     final List<Widget> pages = [
//       _homePage(h, w, sp),
//       Quizzes(),
//       VideoTrainingsScreen(),
//       const Center(child: Text("Advice Page")),
//     ];

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       body: SafeArea(child: pages[_selectedIndex]),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.snackbar("Action", "Create new quiz tapped");
//         },
//         backgroundColor: AppColors.darkblue,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: SizedBox(
//           height: 60,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: w(0.001)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _bottomNavItem(Icons.home, "Home", 0),
//                 _bottomNavItem(Icons.quiz, "Quizzes", 1),
//                 SizedBox(width: w(0.1)),
//                 _bottomNavItem(Icons.bar_chart, "Videos", 2),
//                 _bottomNavItem(Icons.lightbulb, "Advice", 3),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🔹 Home Page Content
//   Widget _homePage(
//     double Function(double) h,
//     double Function(double) w,
//     double Function(double) sp,
//   ) {
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: w(0.05), vertical: h(0.02)),
//       children: [
//         // Header
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "GOOD MORNING",
//                   style: TextStyle(
//                     fontSize: sp(12),
//                     fontWeight: FontWeight.w500,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//                 SizedBox(height: h(0.004)),
//                 Text(
//                   "Bibhu Dash",
//                   style: TextStyle(
//                     fontSize: sp(18),
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             GestureDetector(
//               onTap: () {
//                 Get.to(ViewProfile());
//               },
//               child: CircleAvatar(
//                 radius: 22,
//                 backgroundColor: Colors.grey.shade200,
//                 child: const Icon(Icons.person, size: 26, color: Colors.black),
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: h(0.025)),

//         // 🔹 Dynamic Categories from API
//         Obx(() {
//           if (categoryController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (categoryController.categories.isEmpty) {
//             return const Center(
//               child: Text("⚠️ No categories available or API failed"),
//             );
//           }

//           return Column(
//             children:
//                 categoryController.categories.map((category) {
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     width: double.infinity,
//                     padding: EdgeInsets.all(w(0.04)),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       gradient: const LinearGradient(
//                         colors: [Colors.redAccent, Colors.blueAccent],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             _chip(category.name, Colors.red),
//                             const Spacer(),
//                             const Icon(Icons.close, color: Colors.white),
//                           ],
//                         ),
//                         SizedBox(height: h(0.015)),

//                         Text(
//                           category.description,
//                           style: TextStyle(
//                             fontSize: sp(16),
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(height: h(0.005)),
//                         Text(
//                           "ID: ${category.id}",
//                           style: TextStyle(
//                             fontSize: sp(13),
//                             color: Colors.white70,
//                           ),
//                         ),

//                         SizedBox(height: h(0.015)),
//                         Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 16,
//                               backgroundImage: NetworkImage(
//                                 "https://i.pravatar.cc/150?img=10",
//                               ),
//                             ),
//                             SizedBox(width: w(0.02)),
//                             Text(
//                               "Category\n${category.name}",
//                               style: TextStyle(
//                                 fontSize: sp(12),
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const Spacer(),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 // 👉 Navigate to category details / quizzes
//                               },
//                               child: Text(
//                                 "Start Now",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: sp(13),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//           );
//         }),
//         SizedBox(height: h(0.03)),

//         // Your Quizzes Section
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Your Quizzes",
//               style: TextStyle(fontSize: sp(15), fontWeight: FontWeight.bold),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Get.to(YourQuizzes());
//               },
//               child: Text(
//                 "See all",
//                 style: TextStyle(
//                   fontSize: sp(15),
//                   fontWeight: FontWeight.w500,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         SizedBox(height: h(0.015)),

//         // Quizzes List
//         _quizItem("Stress Checker", "20-09-2025"),
//         _quizItem("General Knowledge", "18-09-2025"),
//         _quizItem("Statistic Quiz", "12-09-2025"),
//       ],
//     );
//   }

//   /// 🔹 Chip Widget
//   Widget _chip(String label, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 11,
//           color: textColor,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   /// 🔹 Quiz Item
//   Widget _quizItem(String title, String date) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 date,
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//               ),
//             ],
//           ),
//           Text(
//             "Result",
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 Bottom Nav Item
//   Widget _bottomNavItem(IconData icon, String label, int index) {
//     final bool isActive = _selectedIndex == index;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: isActive ? AppColors.darkblue : Colors.transparent,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: isActive ? Colors.white : Colors.grey,
//                 size: 22,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isActive ? AppColors.darkblue : Colors.grey,
//                 fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Controller/category_controller.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/model/category_model.dart';
import 'package:quiz/provider/profile_provider.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/category_quiz_screen.dart';
import 'package:quiz/views/profile_view.dart';
import 'package:quiz/views/quizzes_screen.dart';
import 'package:quiz/views/video_screen.dart';
import 'package:quiz/views/videotraining_screeen.dart';
import 'package:quiz/views/your_quezzesscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    // ✅ Fetch profile automatically on screen load
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    // 👇 Pages for bottom nav
    final List<Widget> pages = [
      _homePage(h, w, sp),
      Quizzes(),
      VideoTrainingsScreen(),
      const Center(child: Text("Advice Page")),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(child: pages[_selectedIndex]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar("Action", "Create new quiz tapped");
        },
        backgroundColor: AppColors.darkblue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(0.001)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomNavItem(Icons.home, "Home", 0),
                _bottomNavItem(Icons.quiz, "Quizzes", 1),
                SizedBox(width: w(0.1)),
                _bottomNavItem(Icons.bar_chart, "Videos", 2),
                _bottomNavItem(Icons.lightbulb, "Advice", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Home Page Content
  Widget _homePage(
    double Function(double) h,
    double Function(double) w,
    double Function(double) sp,
  ) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: w(0.05), vertical: h(0.02)),
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "GOOD MORNING",
                  style: TextStyle(
                    fontSize: sp(12),
                    fontWeight: FontWeight.w500,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: h(0.004)),

                // ✅ Dynamic Student Name
                Consumer<ProfileProvider>(
                  builder: (context, profileProvider, child) {
                    if (profileProvider.isLoading) {
                      return Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: sp(18),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    }

                    if (profileProvider.profile == null) {
                      return Text(
                        "GUEST USER",
                        style: TextStyle(
                          fontSize: sp(18),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    }

                    return Text(
                      profileProvider.profile!.studentName.toUpperCase(),
                      style: TextStyle(
                        fontSize: sp(18),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),

            // ✅ Profile Image
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) {
                final profile = profileProvider.profile;

                final String? imageUrl =
                    (profile != null && profile.image.isNotEmpty)
                        ? (profile.image.startsWith("http")
                            ? profile.image
                            : "${AppUrl.baseUrl}${profile.image}")
                        : null;

                return GestureDetector(
                  onTap: () {
                    Get.to(ViewProfile());
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        imageUrl != null ? NetworkImage(imageUrl) : null,
                    child:
                        imageUrl == null
                            ? const Icon(
                              Icons.person,
                              size: 26,
                              color: Colors.black,
                            )
                            : null,
                  ),
                );
              },
            ),
          ],
        ),

        SizedBox(height: h(0.025)),

        // 🔹 Dynamic Quizzes from API
        Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryController.quizzes.isEmpty) {
            return const Center(child: Text("⚠️ No Categories are available"));
          }

          return Column(
            children:
                categoryController.quizzes.map((quiz) {
                  return GestureDetector(
                    onTap: () {
                      // 👉 Navigate to CategoryQuizScreen with hashid
                      Get.to(
                        () => CategoryQuizScreen(
                          hashid: quiz.category.hashid,
                          CategoryName: quiz.category.name,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: double.infinity,
                      padding: EdgeInsets.all(w(0.04)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Colors.redAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: TextStyle(
                              fontSize: sp(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: h(0.005)),
                          Text(
                            quiz.description,
                            style: TextStyle(
                              fontSize: sp(14),
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: h(0.01)),
                          Text(
                            "Category: ${quiz.category.name}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${categoryController.count.value} Videos",
                            style: const TextStyle(color: Colors.white),
                          ),

                          SizedBox(height: h(0.015)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          );
        }),

        SizedBox(height: h(0.03)),

        // Your Quizzes Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Quizzes",
              style: TextStyle(fontSize: sp(15), fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Get.to(YourQuizzes());
              },
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: sp(15),
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: h(0.015)),

        _quizItem("Stress Checker", "20-09-2025"),
        _quizItem("General Knowledge", "18-09-2025"),
        _quizItem("Statistic Quiz", "12-09-2025"),
      ],
    );
  }

  /// 🔹 Quiz Item
  Widget _quizItem(String title, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          Text(
            "Result",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Bottom Nav Item
  Widget _bottomNavItem(IconData icon, String label, int index) {
    final bool isActive = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.darkblue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? AppColors.darkblue : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
