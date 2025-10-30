// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:quiz/api_Services/app_url.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/guardian_screen.dart';
// import 'package:quiz/views/home_screen.dart';
// import 'package:quiz/views/quiz_result_popup_screen.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:quiz/Controller/question_controller.dart';
// import 'package:quiz/Controller/submit_question_controller.dart';
// import 'package:quiz/model/submit_question_model.dart';

// class QuizQuestionScreen extends StatefulWidget {
//   final String title;
//   final String hashid;
//   final String id;

//   const QuizQuestionScreen({
//     super.key,
//     required this.hashid,
//     required this.title,
//     required this.id,
//   });

//   @override
//   State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
// }

// class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
//   final QuestionController _questionController = Get.put(QuestionController());
//   final QuestionSubmitController _quizController = Get.put(
//     QuestionSubmitController(),
//   );

//   int _selectedIndex = -1;
//   int _currentIndex = 0;

//   final FlutterTts flutterTts = FlutterTts();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _spokenText = "";

//   final List<Map<String, dynamic>> _userAnswers = [];

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _questionController.fetchQuestions(widget.hashid);
//   }

//   Future<void> _stopSpeaking() async => await flutterTts.stop();

//   Future<void> _speakQuestion(String question, List<String> options) async {
//     await _stopSpeaking();
//     String textToSpeak = "$question. The options are: ${options.join(", ")}.";
//     await flutterTts.speak(textToSpeak);
//   }

//   Future<void> _listen(List<String> options) async {
//     await _stopSpeaking();
//     if (!_isListening) {
//       bool available = await _speech.initialize();
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) {
//             setState(() {
//               _spokenText = val.recognizedWords.toLowerCase();
//               _matchSpokenAnswer(_spokenText, options);
//             });
//           },
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   void _matchSpokenAnswer(String spoken, List<String> options) {
//     spoken = spoken.toLowerCase().trim();
//     if (spoken.contains("option a") || spoken == "a") {
//       setState(() => _selectedIndex = 0);
//       return;
//     }
//     if (spoken.contains("option b") || spoken == "b") {
//       setState(() => _selectedIndex = 1);
//       return;
//     }
//     if (spoken.contains("option c") || spoken == "c") {
//       setState(() => _selectedIndex = 2);
//       return;
//     }
//     if (spoken.contains("option d") || spoken == "d") {
//       setState(() => _selectedIndex = 3);
//       return;
//     }
//     for (int i = 0; i < options.length; i++) {
//       final optionText =
//           options[i].replaceAll(RegExp(r'[a-dA-D]\)'), '').trim().toLowerCase();
//       if (spoken.contains(optionText)) {
//         setState(() => _selectedIndex = i);
//         break;
//       }
//     }
//   }

//   void _goToNextQuestion() async {
//     await _stopSpeaking();

//     if (_selectedIndex == -1) {
//       Get.snackbar(
//         "No Option Selected",
//         "Please select or say an option first!",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.transparent,
//         colorText: AppColors.white,
//       );
//       return;
//     }

//     final currentQuestion = _questionController.questions[_currentIndex];
//     final selectedOption = currentQuestion.options[_selectedIndex].options;

//     _userAnswers.add({
//       "question_id": currentQuestion.id,
//       "selected_option": selectedOption,
//     });

//     if (_currentIndex < _questionController.questions.length - 1) {
//       setState(() {
//         _currentIndex++;
//         _selectedIndex = -1;
//       });
//     } else {
//       _submitQuiz();
//     }
//   }

//   Future<void> _submitQuiz() async {
//     await _stopSpeaking();
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );

//     try {
//       final params = {
//         "quiz_id": widget.id,
//         "category": widget.title,
//         "answers": _userAnswers,
//       };

//       await _quizController.submitQuiz(params);
//       Get.back();

//       if (_quizController.errorMessage.isNotEmpty) {
//         Get.snackbar(
//           "Error",
//           _quizController.errorMessage.value,
//           backgroundColor: AppColors.red,
//           colorText: AppColors.white,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         final result = _quizController.quizSubmitResponse.value;
//         if (result != null && result.success) {
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return QuizResultPopupScreen(
//                 category: widget.title,
//                 totalQuestions: result.data?.totalQuestions ?? 0,
//                 attempted:
//                     result.data?.summary == null
//                         ? 0
//                         : ((result.data!.summary!.correctAnswers ?? 0) +
//                             (result.data!.summary!.wrongAnswers ?? 0)),
//                 correct: result.data?.summary?.correctAnswers ?? 0,
//                 percentage: result.data?.percentage ?? 0.0,
//                 aiResponse: result.data?.aiFeedback,
//                 detailedAnalysis: result.data?.detailedAnalysis,
//                 onClose: () {
//                   Get.to(HomeScreen());
//                 },
//               );
//             },
//           );
//         }
//       }
//     } catch (e) {
//       Get.back();
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.red,
//         colorText: AppColors.white,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenH = MediaQuery.of(context).size.height;
//     double screenW = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Obx(() {
//           if (_questionController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (_questionController.errorMessage.isNotEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     _questionController.errorMessage.value,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: AppColors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.white,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24,
//                         vertical: 12,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: () => Get.offAll(() => GuardianInfoScreen()),
//                     child: const Text(
//                       "Create Profile",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (_questionController.questions.isEmpty) {
//             return const Center(child: Text("No questions available."));
//           }

//           final currentQuestion = _questionController.questions[_currentIndex];
//           final question = currentQuestion.question;
//           final image = currentQuestion.image;
//           final options =
//               currentQuestion.options.map((opt) => opt.options).toList();
//           final optionLabels = ["a)", "b)", "c)", "d)"];

//           return Padding(
//             padding: EdgeInsets.all(screenW * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         widget.title,
//                         style: TextStyle(
//                           fontSize: screenW * 0.05,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF1A1A40),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: AppColors.black),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: screenH * 0.01),

//                 // Progress bar
//                 Row(
//                   children: List.generate(
//                     _questionController.questions.length,
//                     (index) => Expanded(
//                       child: Container(
//                         height: 3,
//                         margin: const EdgeInsets.symmetric(horizontal: 2),
//                         decoration: BoxDecoration(
//                           color:
//                               index <= _currentIndex
//                                   ? AppColors.lightblue
//                                   : AppColors.grey,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: screenH * 0.02),

//                 // Question + Options + Speaker
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 4,
//                       child: Padding(
//                         padding: EdgeInsets.all(screenW * 0.04),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // ✅ Question image (if any)
//                             if (image != null && image.isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   image.startsWith('http')
//                                       ? image
//                                       : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image",
//                                   height: screenH * 0.25,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return Container(
//                                       height: screenH * 0.25,
//                                       color: Colors.grey.shade200,
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.broken_image,
//                                           size: 60,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),

//                             SizedBox(height: screenH * 0.02),

//                             // ✅ Question + Speaker Icon
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     question,
//                                     style: TextStyle(
//                                       fontSize: screenW * 0.045,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.volume_up,
//                                     color: AppColors.lightblue,
//                                     size: 28,
//                                   ),
//                                   onPressed:
//                                       () => _speakQuestion(question, options),
//                                 ),
//                               ],
//                             ),

//                             SizedBox(height: screenH * 0.02),

//                             // Options
//                             Column(
//                               children: List.generate(options.length, (i) {
//                                 final optionText =
//                                     "${optionLabels[i]} ${options[i]}";
//                                 return _optionTile(
//                                   optionText,
//                                   i,
//                                   screenW,
//                                   screenH,
//                                 );
//                               }),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: screenH * 0.02),

//                 // ✅ Next + Mic Row
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.lightblue,
//                           padding: EdgeInsets.symmetric(
//                             vertical: screenH * 0.018,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: _goToNextQuestion,
//                         child: Text(
//                           _currentIndex <
//                                   _questionController.questions.length - 1
//                               ? "Next"
//                               : "Finish",
//                           style: TextStyle(
//                             fontSize: screenW * 0.045,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     IconButton(
//                       icon: Icon(
//                         _isListening ? Icons.mic : Icons.mic_none,
//                         color: _isListening ? AppColors.red : AppColors.black,
//                         size: screenW * 0.08,
//                       ),
//                       onPressed: () => _listen(options),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget _optionTile(String text, int index, double w, double h) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedIndex = index),
//       child: Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(bottom: h * 0.015),
//         padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.03),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blue.shade100 : Colors.white,
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey.shade400,
//             width: 1.2,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: w * 0.04,
//             fontWeight: FontWeight.w500,
//             color: isSelected ? Colors.blue : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quiz/api_Services/app_url.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/guardian_screen.dart';
import 'package:quiz/views/home_screen.dart';
import 'package:quiz/views/quiz_result_popup_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:quiz/Controller/question_controller.dart';
import 'package:quiz/Controller/submit_question_controller.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String title;
  final String hashid;
  final String id;

  const QuizQuestionScreen({
    super.key,
    required this.hashid,
    required this.title,
    required this.id,
  });

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final QuestionController _questionController = Get.put(QuestionController());
  final QuestionSubmitController _quizController = Get.put(
    QuestionSubmitController(),
  );

  int _selectedIndex = -1;
  int _currentIndex = 0;
  final FlutterTts flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isImageLoading = false;
  bool _isCorrectSpoken = false;
  String _spokenText = "";

  final List<Map<String, dynamic>> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _questionController.fetchQuestions(widget.hashid);
  }

  Future<void> _stopSpeaking() async => await flutterTts.stop();

  Future<void> _speakQuestion(String question, List<String> options) async {
    await _stopSpeaking();
    String textToSpeak = "$question. The options are: ${options.join(", ")}.";
    await flutterTts.speak(textToSpeak);
  }

  Future<void> _listen(List<String> options) async {
    await _stopSpeaking();
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _isCorrectSpoken = false;
        });
        _speech.listen(
          onResult: (val) {
            setState(() {
              _spokenText = val.recognizedWords.toLowerCase();
              _matchSpokenAnswer(_spokenText, options);
            });
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _isCorrectSpoken = false;
      });
      _speech.stop();
    }
  }

  void _matchSpokenAnswer(String spoken, List<String> options) {
    spoken = spoken.toLowerCase().trim();
    bool matched = false;

    if (spoken.contains("option a") || spoken == "a") {
      setState(() {
        _selectedIndex = 0;
        matched = true;
      });
    } else if (spoken.contains("option b") || spoken == "b") {
      setState(() {
        _selectedIndex = 1;
        matched = true;
      });
    } else if (spoken.contains("option c") || spoken == "c") {
      setState(() {
        _selectedIndex = 2;
        matched = true;
      });
    } else if (spoken.contains("option d") || spoken == "d") {
      setState(() {
        _selectedIndex = 3;
        matched = true;
      });
    } else {
      for (int i = 0; i < options.length; i++) {
        final optionText =
            options[i]
                .replaceAll(RegExp(r'[a-dA-D]\)'), '')
                .trim()
                .toLowerCase();
        if (spoken.contains(optionText)) {
          setState(() {
            _selectedIndex = i;
            matched = true;
          });
          break;
        }
      }
    }

    if (matched) {
      setState(() {
        _isCorrectSpoken = true;
        _isListening = false;
      });
      _speech.stop();
    }
  }

  void _goToNextQuestion() async {
    await _stopSpeaking();

    if (_selectedIndex == -1) {
      Get.snackbar(
        "No Option Selected",
        "Please select or say an option first!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.transparent,
        colorText: AppColors.white,
      );
      return;
    }

    final currentQuestion = _questionController.questions[_currentIndex];
    final selectedOption = currentQuestion.options[_selectedIndex].options;

    _userAnswers.add({
      "question_id": currentQuestion.id,
      "selected_option": selectedOption,
    });

    if (_currentIndex < _questionController.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = -1;
        _isImageLoading = false;
        _isCorrectSpoken = false;
      });
    } else {
      _submitQuiz();
    }
  }

  Future<void> _submitQuiz() async {
    await _stopSpeaking();
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final params = {
        "quiz_id": widget.id,
        "category": widget.title,
        "answers": _userAnswers,
      };

      await _quizController.submitQuiz(params);
      Get.back();

      if (_quizController.errorMessage.isNotEmpty) {
        Get.snackbar(
          "Error",
          _quizController.errorMessage.value,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final result = _quizController.quizSubmitResponse.value;
        if (result != null && result.success) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return QuizResultPopupScreen(
                category: widget.title,
                totalQuestions: result.data?.totalQuestions ?? 0,
                attempted:
                    result.data?.summary == null
                        ? 0
                        : ((result.data!.summary!.correctAnswers ?? 0) +
                            (result.data!.summary!.wrongAnswers ?? 0)),
                correct: result.data?.summary?.correctAnswers ?? 0,
                percentage: result.data?.percentage ?? 0.0,
                aiResponse: result.data?.aiFeedback,
                detailedAnalysis: result.data?.detailedAnalysis,
                recomendations: result.data?.categoryRecommendations,
                onClose: () {
                  Get.to(HomeScreen());
                },
              );
            },
          );
        }
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          if (_questionController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_questionController.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _questionController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Get.offAll(() => GuardianInfoScreen()),
                    child: const Text(
                      "Create Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (_questionController.questions.isEmpty) {
            return const Center(child: Text("No questions available."));
          }

          final currentQuestion = _questionController.questions[_currentIndex];
          final question = currentQuestion.question;
          final image = currentQuestion.image;
          final options =
              currentQuestion.options.map((opt) => opt.options).toList();
          final optionLabels = ["a)", "b)", "c)", "d)"];

          return Padding(
            padding: EdgeInsets.all(screenW * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: screenW * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A40),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                SizedBox(height: screenH * 0.01),

                // Progress bar
                Row(
                  children: List.generate(
                    _questionController.questions.length,
                    (index) => Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color:
                              index <= _currentIndex
                                  ? AppColors.lightblue
                                  : AppColors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenH * 0.02),

                // Question card
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(screenW * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ✅ Image with loading indicator
                            if (image != null && image.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  image.startsWith('http')
                                      ? image
                                      : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image",
                                  height: screenH * 0.25,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      if (_isImageLoading) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              setState(
                                                () => _isImageLoading = false,
                                              );
                                            });
                                      }
                                      return child;
                                    } else {
                                      if (!_isImageLoading) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                              setState(
                                                () => _isImageLoading = true,
                                              );
                                            });
                                      }
                                      return Container(
                                        height: screenH * 0.25,
                                        width: double.infinity,
                                        color: Colors.grey.shade200,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),

                            SizedBox(height: screenH * 0.02),

                            // Question with speaker
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    question,
                                    style: TextStyle(
                                      fontSize: screenW * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.volume_up,
                                    color: AppColors.black,
                                  ),
                                  onPressed:
                                      () => _speakQuestion(question, options),
                                ),
                              ],
                            ),

                            SizedBox(height: screenH * 0.02),

                            // Options
                            Column(
                              children: List.generate(options.length, (i) {
                                final optionText =
                                    "${optionLabels[i]} ${options[i]}";
                                return _optionTile(
                                  optionText,
                                  i,
                                  screenW,
                                  screenH,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenH * 0.02),

                // ✅ Next + Mic Row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isImageLoading
                                  ? Colors.grey
                                  : AppColors.lightblue,
                          padding: EdgeInsets.symmetric(
                            vertical: screenH * 0.018,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _isImageLoading ? null : _goToNextQuestion,
                        child: Text(
                          _currentIndex <
                                  _questionController.questions.length - 1
                              ? "Next"
                              : "Finish",
                          style: TextStyle(
                            fontSize: screenW * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        _isCorrectSpoken
                            ? Icons.mic
                            : _isListening
                            ? Icons.mic
                            : Icons.mic_none,
                        color:
                            _isCorrectSpoken
                                ? Colors.black
                                : _isListening
                                ? Colors.red
                                : Colors.black54,
                        size: screenW * 0.08,
                      ),
                      onPressed: () => _listen(options),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _optionTile(String text, int index, double w, double h) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.03),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }
}
