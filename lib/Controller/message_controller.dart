// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:quiz/api_Services/repo.dart';
// import 'package:quiz/model/message_model.dart';

// class ChatController extends GetxController {
//   final ApiService apiService = ApiService();

//   /// 🔹 Observables
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var messages = <ChatMessage>[].obs; // combined user + bot messages

//   /// 🔹 Send a new message to the chatbot API
//   Future<void> sendMessage(String content) async {
//     if (content.trim().isEmpty) return;

//     try {
//       isLoading(true);
//       errorMessage('');

//       // 🧠 Add user message locally first
//       messages.add(ChatMessage(sender: 'user', content: content));

//       // 📨 Call API
//       final response = await apiService.messaging(content: content);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.toString());
//         final chatResponse = ChatResponse.fromJson(data);

//         // ✅ Add bot response if available
//         if (chatResponse.botMessage != null) {
//           messages.add(
//             ChatMessage(
//               sender: chatResponse.botMessage!.sender ?? 'bot',
//               content: chatResponse.botMessage!.content ?? '',
//             ),
//           );
//         }
//       } else {
//         errorMessage.value = 'Failed to send message: ${response.statusCode}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error sending message: $e';
//       print('ChatController error: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   /// 🔹 Clear chat
//   void clearChat() {
//     messages.clear();
//   }
// }

// /// 🔹 Simple chat message model for UI
// class ChatMessage {
//   final String sender; // "user" or "bot"
//   final String content;

//   ChatMessage({required this.sender, required this.content});
// }

import 'dart:convert';
import 'package:get/get.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/message_model.dart';

class ChatController extends GetxController {
  final ApiService apiService = ApiService();

  /// 🔹 Observables
  var isLoading = false.obs;
  var isThinking = false.obs; // 👈 Added for "Thinking..." placeholder
  var errorMessage = ''.obs;
  var messages = <ChatMessage>[].obs;

  /// 🔹 Send message to chatbot
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    try {
      isLoading(true);
      errorMessage('');

      // 🧠 Add user's message immediately
      messages.add(ChatMessage(sender: 'user', content: content));

      // 🕒 Show thinking placeholder
      isThinking(true);
      messages.add(ChatMessage(sender: 'bot', content: 'Thinking...'));

      // 📨 API call
      final response = await apiService.messaging(content: content);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.toString());
        final chatResponse = ChatResponse.fromJson(data);

        // 🧹 Remove the "Thinking..." placeholder before adding real response
        if (messages.isNotEmpty && messages.last.content == 'Thinking...') {
          messages.removeLast();
        }

        // ✅ Add bot response
        if (chatResponse.botMessage != null) {
          messages.add(
            ChatMessage(
              sender: chatResponse.botMessage!.sender ?? 'bot',
              content: chatResponse.botMessage!.content ?? '',
            ),
          );
        }
      } else {
        errorMessage.value = 'Failed to send message: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error sending message: $e';
      print('ChatController error: $e');
    } finally {
      isThinking(false);
      isLoading(false);
    }
  }

  /// 🔹 Clear chat
  void clearChat() {
    messages.clear();
    errorMessage('');
  }
}

/// 🔹 Local chat message model (used by the screen)
class ChatMessage {
  final String sender; // "user" or "bot"
  final String content;

  ChatMessage({required this.sender, required this.content});
}
