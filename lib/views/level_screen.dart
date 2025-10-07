// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quiz/controller/level_controller.dart';
// import 'package:quiz/utils/colors.dart';

// class LevelScreen extends StatelessWidget {
//   final String title;
//   final String hashid;
//   final LevelController levelController = Get.put(LevelController());

//   LevelScreen({super.key, required this.hashid, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     // Fetch levels when screen loads
//     print("Title is $title and the hashid is $hashid");
//     levelController.fetchLevels();

//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "Quiz Levels",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       // ✅ BOTTOM CARD AREA
//       body: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           width: double.infinity,

//           // 👇 CHANGE HEIGHT HERE
//           // For example: 0.75 = 75% of screen height
//           height: MediaQuery.of(context).size.height * 0.45,

//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -4),
//               ),
//             ],
//           ),

//           padding: const EdgeInsets.all(16),
//           child: Obx(() {
//             if (levelController.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (levelController.levels.isEmpty) {
//               return const Center(
//                 child: Text(
//                   "No Levels Available 😕",
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//               );
//             }

//             return ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: levelController.levels.length,
//               itemBuilder: (context, index) {
//                 final level = levelController.levels[index];

//                 return Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey[100],
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 16,
//                     ),
//                     leading: CircleAvatar(
//                       radius: 25,
//                       backgroundColor: AppColors.black,
//                       child: Text(
//                         level.name.substring(0, 1).toUpperCase(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                     title: Text(
//                       level.name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     trailing: const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.black45,
//                       size: 20,
//                     ),
//                     onTap: () {
//                       Get.snackbar(
//                         "Level Selected",
//                         "You selected: ${level.name}",
//                         backgroundColor: Colors.black87,
//                         colorText: Colors.white,
//                         snackPosition: SnackPosition.BOTTOM,
//                         margin: const EdgeInsets.all(10),
//                         borderRadius: 10,
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/level_controller.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/Quiz_questionscreen.dart';

class LevelScreen extends StatelessWidget {
  final String title;
  final String hashid;
  final String id;
  final LevelController levelController = Get.put(LevelController());

  LevelScreen({
    super.key,
    required this.hashid,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    print(
      "Title is $title and hashid is $hashid OOOOOOOOOOOOOR ID is $id",
    ); // ✅ added missing semicolon

    // ✅ Fetch levels once when screen loads
    levelController.fetchLevels();

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Quiz Levels",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),

      // ✅ BOTTOM CARD AREA
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            if (levelController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (levelController.levels.isEmpty) {
              return const Center(
                child: Text(
                  "No Levels Available 😕",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              );
            }

            return Stack(
              children: [
                // ✅ LEVEL LIST
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: levelController.levels.length,
                  itemBuilder: (context, index) {
                    final level = levelController.levels[index];

                    return Obx(() {
                      bool isSelected =
                          levelController.selectedLevel.value == level.name;

                      return GestureDetector(
                        onTap: () async {
                          // ✅ Post selected level
                          await levelController.addLevel(level.name);

                          // ✅ Update selected visually
                          levelController.selectedLevel.value = level.name;
                          Get.to(
                            QuizQuestionScreen(
                              title: title,
                              hashid: hashid,
                              id: id,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                isSelected
                                    ? AppColors.black.withOpacity(0.85)
                                    : Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  isSelected ? Colors.white : AppColors.black,
                              child: Text(
                                level.name.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? AppColors.black
                                          : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            title: Text(
                              level.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color:
                                  isSelected ? Colors.white70 : Colors.black45,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),

                // ✅ Loader overlay when posting
                Obx(
                  () =>
                      levelController.isPosting.value
                          ? Container(
                            color: Colors.black26,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                          : const SizedBox(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
