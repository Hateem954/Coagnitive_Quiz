// import 'package:flutter/material.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/images.dart';

// class QuizQuestionScreen extends StatefulWidget {
//   const QuizQuestionScreen({super.key});

//   @override
//   State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
// }

// class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
//   int _selectedIndex = -1; // to track selected option

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

//               // 🔹 Category + Q No + Timer
//               const SizedBox(height: 16),

//               // 🔹 Card containing Image + Question + Options
//               Expanded(
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(color: Colors.red),
//                               ),
//                               child: const Text(
//                                 "General Knowledge",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             _chip("Q1"),
//                             const SizedBox(width: 8),
//                             _chip("30"),
//                           ],
//                         ),
//                         // Image
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: CustomImageContainer(
//                             height: 250,
//                             width: double.infinity,
//                             imageUrl: AppImages.Welcome,
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Question
//                         const Text(
//                           "What is the capital city of Australia?",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Options
//                         _optionTile("a) Sydney", 0),
//                         _optionTile("b) Canberra", 1),
//                         _optionTile("c) Brisbane", 2),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // 🔹 Next Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (_selectedIndex != -1) {
//                       // move to next question
//                     }
//                   },
//                   child: const Text(
//                     "Next",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
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

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int _selectedIndex = -1; // to track selected option
  final FlutterTts flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = "";

  final String question = "What is the capital city of Australia?";
  final List<String> options = ["a) Sydney", "b) Canberra", "c) Brisbane"];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  /// 🔹 Speak Question + Options
  Future<void> _speakQuestion() async {
    String textToSpeak = "$question. The options are. ${options.join(", ")}";
    await flutterTts.speak(textToSpeak);
  }

  /// 🔹 Start Listening for Answer
  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _spokenText = val.recognizedWords.toLowerCase();
              _matchSpokenAnswer(_spokenText);
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  /// 🔹 Match spoken text to an option
  void _matchSpokenAnswer(String spoken) {
    spoken = spoken.toLowerCase();

    // Match "option a/b/c" or just "a/b/c"
    if (spoken.contains("option a") || spoken.trim() == "a") {
      setState(() => _selectedIndex = 0);
      return;
    }
    if (spoken.contains("option b") || spoken.trim() == "b") {
      setState(() => _selectedIndex = 1);
      return;
    }
    if (spoken.contains("option c") || spoken.trim() == "c") {
      setState(() => _selectedIndex = 2);
      return;
    }

    // Match by actual option text (Sydney, Canberra, Brisbane)
    for (int i = 0; i < options.length; i++) {
      final optionText = options[i].split(")").last.trim().toLowerCase();
      if (spoken.contains(optionText)) {
        setState(() => _selectedIndex = i);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Stress Checker",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A40),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black87),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 🔹 Progress bar (fake stepper)
              Row(
                children: List.generate(
                  6,
                  (index) => Expanded(
                    child: Container(
                      height: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.blue : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 Card containing Image + Question + Options
              Expanded(
                child: GestureDetector(
                  onTap: _speakQuestion, // 👈 Speak when tapped
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: const Text(
                                  "General Knowledge",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _chip("Q1"),
                              const SizedBox(width: 8),
                              _chip("30"),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomImageContainer(
                              height: 200,
                              width: double.infinity,
                              imageUrl: AppImages.Welcome,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Question
                          Text(
                            question,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Options
                          for (int i = 0; i < options.length; i++)
                            _optionTile(options[i], i),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Mic + Next Button
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    onPressed: _listen, // 👈 Start/Stop listening
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_selectedIndex != -1) {
                          // move to next question
                        }
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
    );
  }

  /// 🔹 Option Widget
  Widget _optionTile(String text, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable Chip
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
