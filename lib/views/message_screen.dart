import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/Controller/message_controller.dart';
import 'package:quiz/utils/colors.dart';
import 'package:quiz/utils/customimage.dart';
import 'package:quiz/utils/images.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Get.back(),
        ),

        /// ✅ Custom title row with avatar + title
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(AppImages.bot),
              backgroundColor: AppColors.white,
            ),
            const SizedBox(width: 10),
            const Text(
              'Speaking AI Chat',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.black87),
            onPressed: () => chatController.clearChat(),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value &&
                  chatController.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (chatController.messages.isEmpty) {
                return const Center(
                  child: Text(
                    'Start a conversation...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 14,
                ),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatController.messages[index];
                  final isUser = msg.sender == 'user';

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        gradient:
                            isUser
                                ? const LinearGradient(
                                  colors: [
                                    Color(0xFF4C8BF5),
                                    Color(0xFF2563EB),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                : null,
                        color: isUser ? null : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft:
                              isUser
                                  ? const Radius.circular(18)
                                  : const Radius.circular(4),
                          bottomRight:
                              isUser
                                  ? const Radius.circular(4)
                                  : const Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _buildMessageText(msg.content, isUser),
                    ),
                  );
                },
              );
            }),
          ),

          _buildInputArea(),
        ],
      ),
    );
  }

  /// Input bar
  Widget _buildInputArea() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: Colors.grey[100],
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Message text with Read More
  Widget _buildMessageText(String text, bool isUser) {
    final RxBool expanded = false.obs;
    final bool isLong = text.length > 500;
    final String preview = text.substring(0, isLong ? 500 : text.length);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expanded.value || !isLong ? text : '$preview...',
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black87,
              fontSize: 15,
            ),
          ),
          if (isLong)
            GestureDetector(
              onTap: () => expanded.value = !expanded.value,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  expanded.value ? 'Read less' : 'Read more',
                  style: TextStyle(
                    color: isUser ? Colors.white70 : Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final content = messageController.text.trim();
    if (content.isEmpty) return;
    chatController.sendMessage(content);
    messageController.clear();
  }
}
