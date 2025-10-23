// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';

// class QuizQuestionScreen extends StatefulWidget {
//   final String title;
//   final String hashid;
//   const QuizQuestionScreen({
//     super.key,
//     required this.hashid,
//     required this.title,
//   });

//   @override
//   State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
// }

// class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
//   int _selectedIndex = -1; // to track selected option
//   final FlutterTts flutterTts = FlutterTts();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _spokenText = "";

//   final String question = "What is the capital city of Australia?";
//   final List<String> options = ["a) Sydney", "b) Canberra", "c) Brisbane"];

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   /// 🔹 Speak Question + Options
//   Future<void> _speakQuestion() async {
//     String textToSpeak = "$question. The options are. ${options.join(", ")}";
//     await flutterTts.speak(textToSpeak);
//   }

//   /// 🔹 Start Listening for Answer
//   Future<void> _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize();
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) {
//             setState(() {
//               _spokenText = val.recognizedWords.toLowerCase();
//               _matchSpokenAnswer(_spokenText);
//             });
//           },
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   /// 🔹 Match spoken text to an option
//   void _matchSpokenAnswer(String spoken) {
//     spoken = spoken.toLowerCase();

//     // Match "option a/b/c" or just "a/b/c"
//     if (spoken.contains("option a") || spoken.trim() == "a") {
//       setState(() => _selectedIndex = 0);
//       return;
//     }
//     if (spoken.contains("option b") || spoken.trim() == "b") {
//       setState(() => _selectedIndex = 1);
//       return;
//     }
//     if (spoken.contains("option c") || spoken.trim() == "c") {
//       setState(() => _selectedIndex = 2);
//       return;
//     }

//     // Match by actual option text (Sydney, Canberra, Brisbane)
//     for (int i = 0; i < options.length; i++) {
//       final optionText = options[i].split(")").last.trim().toLowerCase();
//       if (spoken.contains(optionText)) {
//         setState(() => _selectedIndex = i);
//         break;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔹 Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Stress Checker",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1A1A40),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close, color: Colors.black87),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // 🔹 Progress bar (fake stepper)
//               Row(
//                 children: List.generate(
//                   6,
//                   (index) => Expanded(
//                     child: Container(
//                       height: 3,
//                       margin: const EdgeInsets.symmetric(horizontal: 2),
//                       decoration: BoxDecoration(
//                         color: index == 0 ? Colors.blue : Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // 🔹 Card containing Image + Question + Options
//               Expanded(
//                 child: GestureDetector(
//                   onTap: _speakQuestion, // 👈 Speak when tapped
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(color: Colors.red),
//                                 ),
//                                 child: const Text(
//                                   "General Knowledge",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               _chip("Q1"),
//                               const SizedBox(width: 8),
//                               _chip("30"),
//                             ],
//                           ),
//                           const SizedBox(height: 16),

//                           // Image
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: CustomImageContainer(
//                               height: 200,
//                               width: double.infinity,
//                               imageUrl: AppImages.Welcome,
//                             ),
//                           ),
//                           const SizedBox(height: 16),

//                           // Question
//                           Text(
//                             question,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 16),

//                           // Options
//                           for (int i = 0; i < options.length; i++)
//                             _optionTile(options[i], i),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // 🔹 Mic + Next Button
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _isListening ? Icons.mic : Icons.mic_none,
//                       color: _isListening ? Colors.red : Colors.grey,
//                       size: 30,
//                     ),
//                     onPressed: _listen, // 👈 Start/Stop listening
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_selectedIndex != -1) {
//                           // move to next question
//                         }
//                       },
//                       child: const Text(
//                         "Next",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🔹 Option Widget
//   Widget _optionTile(String text, int index) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//             color: isSelected ? Colors.blue : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🔹 Reusable Chip
//   Widget _chip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade400),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
// }
//////0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// import 'package:quiz/Controller/question_controller.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';

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

//   int _selectedIndex = -1;
//   int _currentIndex = 0;

//   final FlutterTts flutterTts = FlutterTts();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _spokenText = "";

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _questionController.fetchQuestions(widget.hashid);
//   }

//   /// 🔹 Speak Question + Options
//   Future<void> _speakQuestion(String question, List<String> options) async {
//     String textToSpeak = "$question. The options are. ${options.join(", ")}";
//     await flutterTts.speak(textToSpeak);
//   }

//   /// 🔹 Start Listening for Answer
//   Future<void> _listen(List<String> options) async {
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

//   /// 🔹 Match spoken text to option
//   void _matchSpokenAnswer(String spoken, List<String> options) {
//     spoken = spoken.toLowerCase().trim();

//     // Match letters
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

//     // Match actual option text (ignoring letters like "a)" etc.)
//     for (int i = 0; i < options.length; i++) {
//       final optionText =
//           options[i].replaceAll(RegExp(r'[a-dA-D]\)'), '').trim().toLowerCase();
//       if (spoken.contains(optionText)) {
//         setState(() => _selectedIndex = i);
//         break;
//       }
//     }
//   }

//   /// 🔹 Move to next question
//   void _goToNextQuestion() {
//     if (_selectedIndex == -1) {
//       Get.snackbar(
//         "No Option Selected",
//         "Please select an option first!",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     if (_currentIndex < _questionController.questions.length - 1) {
//       setState(() {
//         _currentIndex++;
//         _selectedIndex = -1;
//       });
//     } else {
//       Get.snackbar(
//         "Quiz Completed",
//         "You’ve reached the end of the quiz!",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
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
//               child: Text(
//                 _questionController.errorMessage.value,
//                 style: const TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             );
//           }

//           if (_questionController.questions.isEmpty) {
//             return const Center(child: Text("No questions available."));
//           }

//           final question =
//               _questionController.questions[_currentIndex].question;
//           final options =
//               _questionController.questions[_currentIndex].options
//                   .map((opt) => opt.options)
//                   .toList();

//           return Padding(
//             padding: EdgeInsets.all(screenW * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 🔹 Header
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
//                       icon: const Icon(Icons.close, color: Colors.black87),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: screenH * 0.01),

//                 // 🔹 Progress bar
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
//                                   ? Colors.blue
//                                   : Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenH * 0.02),

//                 // 🔹 Scrollable Question Section
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: GestureDetector(
//                       onTap: () => _speakQuestion(question, options),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         elevation: 4,
//                         child: Padding(
//                           padding: EdgeInsets.all(screenW * 0.04),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   _chip("Q${_currentIndex + 1}"),
//                                   const SizedBox(width: 8),
//                                   _chip(
//                                     "${_questionController.questions.length - _currentIndex} left",
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: screenH * 0.02),

//                               // 🔹 Image
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: CustomImageContainer(
//                                   height: screenH * 0.25,
//                                   width: double.infinity,
//                                   imageUrl: AppImages.Welcome,
//                                 ),
//                               ),
//                               SizedBox(height: screenH * 0.02),

//                               // 🔹 Question
//                               Text(
//                                 question,
//                                 style: TextStyle(
//                                   fontSize: screenW * 0.045,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               SizedBox(height: screenH * 0.02),

//                               // 🔹 Options
//                               for (int i = 0; i < options.length; i++)
//                                 _optionTile(options[i], i, screenW, screenH),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: screenH * 0.02),

//                 // 🔹 Mic + Next Button
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         _isListening ? Icons.mic : Icons.mic_none,
//                         color: _isListening ? Colors.red : Colors.grey,
//                         size: screenW * 0.08,
//                       ),
//                       onPressed: () => _listen(options),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
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
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
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

//   /// 🔹 Option Widget
//   Widget _optionTile(String text, int index, double w, double h) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedIndex = index),
//       child: Container(
//         margin: EdgeInsets.only(bottom: h * 0.015),
//         padding: EdgeInsets.symmetric(
//           vertical: h * 0.018,
//           horizontal: w * 0.03,
//         ),
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

//   /// 🔹 Reusable Chip
//   Widget _chip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade400),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
// }
///00000000000000000000000000000000000 abaaaaaaaaaaaaaaaaaaay yai shi hai000000000000000000000000000000000000000
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// import 'package:quiz/Controller/question_controller.dart';
// import 'package:quiz/Controller/submit_question_controller.dart'; // updated controller
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';
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

//   // ✅ Store user’s answers
//   final List<Map<String, dynamic>> _userAnswers = [];

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _questionController.fetchQuestions(widget.hashid);
//   }

//   /// 🔹 Speak Question + Options
//   Future<void> _speakQuestion(String question, List<String> options) async {
//     String textToSpeak = "$question. The options are. ${options.join(", ")}";
//     await flutterTts.speak(textToSpeak);
//   }

//   /// 🔹 Start Listening for Answer
//   Future<void> _listen(List<String> options) async {
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

//   /// 🔹 Match spoken text to option
//   void _matchSpokenAnswer(String spoken, List<String> options) {
//     spoken = spoken.toLowerCase().trim();

//     // Match letters
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

//     // Match actual option text
//     for (int i = 0; i < options.length; i++) {
//       final optionText =
//           options[i].replaceAll(RegExp(r'[a-dA-D]\)'), '').trim().toLowerCase();
//       if (spoken.contains(optionText)) {
//         setState(() => _selectedIndex = i);
//         break;
//       }
//     }
//   }

//   /// 🔹 Move to next question or submit quiz
//   void _goToNextQuestion() {
//     if (_selectedIndex == -1) {
//       Get.snackbar(
//         "No Option Selected",
//         "Please select an option first!",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     final currentQuestion = _questionController.questions[_currentIndex];
//     final selectedOption = currentQuestion.options[_selectedIndex].options;

//     // ✅ Save user's answer in API format
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
//       // ✅ Submit quiz
//       _submitQuiz();
//     }
//   }

//   /// 🔹 Submit quiz to backend
//   Future<void> _submitQuiz() async {
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

//       Get.back(); // close loader

//       if (_quizController.errorMessage.isNotEmpty) {
//         Get.snackbar(
//           "Error",
//           _quizController.errorMessage.value,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       } else {
//         final result = _quizController.quizSubmitResponse.value;
//         if (result != null && result.success) {
//           Get.snackbar(
//             "Quiz Submitted!",
//             "Score: ${result.data?.score}/${result.data?.totalQuestions}\n${result.data?.aiFeedback ?? ''}",
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//             duration: const Duration(seconds: 5),
//           );
//         }
//       }
//     } catch (e) {
//       Get.back();
//       Get.snackbar(
//         "Error",
//         "Something went wrong: $e",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
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
//               child: Text(
//                 _questionController.errorMessage.value,
//                 style: const TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             );
//           }

//           if (_questionController.questions.isEmpty) {
//             return const Center(child: Text("No questions available."));
//           }

//           final question =
//               _questionController.questions[_currentIndex].question;
//           final options =
//               _questionController.questions[_currentIndex].options
//                   .map((opt) => opt.options)
//                   .toList();

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
//                       icon: const Icon(Icons.close, color: Colors.black87),
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
//                                   ? Colors.blue
//                                   : Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(2),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenH * 0.02),

//                 // Scrollable Question Section
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: GestureDetector(
//                       onTap: () => _speakQuestion(question, options),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         elevation: 4,
//                         child: Padding(
//                           padding: EdgeInsets.all(screenW * 0.04),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   _chip("Q${_currentIndex + 1}"),
//                                   const SizedBox(width: 8),
//                                   _chip(
//                                     "${_questionController.questions.length - _currentIndex} left",
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: screenH * 0.02),

//                               // Image
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: CustomImageContainer(
//                                   height: screenH * 0.25,
//                                   width: double.infinity,
//                                   imageUrl: AppImages.Welcome,
//                                 ),
//                               ),
//                               SizedBox(height: screenH * 0.02),

//                               // Question
//                               Text(
//                                 question,
//                                 style: TextStyle(
//                                   fontSize: screenW * 0.045,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               SizedBox(height: screenH * 0.02),

//                               // Options
//                               for (int i = 0; i < options.length; i++)
//                                 _optionTile(options[i], i, screenW, screenH),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: screenH * 0.02),

//                 // Mic + Next Button
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         _isListening ? Icons.mic : Icons.mic_none,
//                         color: _isListening ? Colors.red : Colors.grey,
//                         size: screenW * 0.08,
//                       ),
//                       onPressed: () => _listen(options),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
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
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
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

//   /// Option Widget
//   Widget _optionTile(String text, int index, double w, double h) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedIndex = index),
//       child: Container(
//         margin: EdgeInsets.only(bottom: h * 0.015),
//         padding: EdgeInsets.symmetric(
//           vertical: h * 0.018,
//           horizontal: w * 0.03,
//         ),
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

//   /// Reusable Chip
//   Widget _chip(String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade400),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/views/home_screen.dart';
import 'package:quiz/views/quiz_result_popup_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:quiz/Controller/question_controller.dart';
import 'package:quiz/Controller/submit_question_controller.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';
import 'package:quiz/model/submit_question_model.dart';

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
  String _spokenText = "";

  final List<Map<String, dynamic>> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _questionController.fetchQuestions(widget.hashid);
  }

  Future<void> _speakQuestion(String question, List<String> options) async {
    String textToSpeak = "$question. The options are. ${options.join(", ")}";
    await flutterTts.speak(textToSpeak);
  }

  Future<void> _listen(List<String> options) async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
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
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _matchSpokenAnswer(String spoken, List<String> options) {
    spoken = spoken.toLowerCase().trim();

    if (spoken.contains("option a") || spoken == "a") {
      setState(() => _selectedIndex = 0);
      return;
    }
    if (spoken.contains("option b") || spoken == "b") {
      setState(() => _selectedIndex = 1);
      return;
    }
    if (spoken.contains("option c") || spoken == "c") {
      setState(() => _selectedIndex = 2);
      return;
    }
    if (spoken.contains("option d") || spoken == "d") {
      setState(() => _selectedIndex = 3);
      return;
    }

    for (int i = 0; i < options.length; i++) {
      final optionText =
          options[i].replaceAll(RegExp(r'[a-dA-D]\)'), '').trim().toLowerCase();
      if (spoken.contains(optionText)) {
        setState(() => _selectedIndex = i);
        break;
      }
    }
  }

  void _goToNextQuestion() {
    if (_selectedIndex == -1) {
      Get.snackbar(
        "No Option Selected",
        "Please select an option first!",
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
      });
    } else {
      _submitQuiz();
    }
  }

  /// 🔹 Submit quiz and show popup
  Future<void> _submitQuiz() async {
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
          // ✅ Show your custom popup instead of snackbar
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
                aiResponse:
                    result.data?.aiFeedback, // ✅ Pass the AI feedback here
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
              child: Text(
                _questionController.errorMessage.value,
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          }

          if (_questionController.questions.isEmpty) {
            return const Center(child: Text("No questions available."));
          }

          final question =
              _questionController.questions[_currentIndex].question;
          final options =
              _questionController.questions[_currentIndex].options
                  .map((opt) => opt.options)
                  .toList();

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

                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () => _speakQuestion(question, options),
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
                              Row(
                                children: [
                                  _chip("Q${_currentIndex + 1}"),
                                  const SizedBox(width: 8),
                                  _chip(
                                    "${_questionController.questions.length - _currentIndex} left",
                                  ),
                                ],
                              ),
                              SizedBox(height: screenH * 0.02),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CustomImageContainer(
                                  height: screenH * 0.25,
                                  width: double.infinity,
                                  imageUrl: AppImages.Welcome,
                                ),
                              ),
                              SizedBox(height: screenH * 0.02),
                              Text(
                                question,
                                style: TextStyle(
                                  fontSize: screenW * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: screenH * 0.02),
                              for (int i = 0; i < options.length; i++)
                                _optionTile(options[i], i, screenW, screenH),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenH * 0.02),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: _isListening ? AppColors.red : AppColors.grey,
                        size: screenW * 0.08,
                      ),
                      onPressed: () => _listen(options),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightblue,
                          padding: EdgeInsets.symmetric(
                            vertical: screenH * 0.018,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _goToNextQuestion,
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
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.symmetric(
          vertical: h * 0.018,
          horizontal: w * 0.03,
        ),
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

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

/// 👇 New screen to show AI feedback after pressing “View Answersheet”
class AiResponseScreen extends StatelessWidget {
  final String aiResponse;
  const AiResponseScreen({super.key, required this.aiResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Feedback"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          aiResponse,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
