class ChatResponse {
  final UserMessage? userMessage;
  final BotMessage? botMessage;

  ChatResponse({this.userMessage, this.botMessage});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      userMessage:
          json['user_message'] != null
              ? UserMessage.fromJson(json['user_message'])
              : null,
      botMessage:
          json['bot_message'] != null
              ? BotMessage.fromJson(json['bot_message'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_message': userMessage?.toJson(),
      'bot_message': botMessage?.toJson(),
    };
  }
}

class UserMessage {
  final int? userId;
  final String? content;
  final String? sender;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  UserMessage({
    this.userId,
    this.content,
    this.sender,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserMessage.fromJson(Map<String, dynamic> json) {
    return UserMessage(
      userId: json['user_id'],
      content: json['content'],
      sender: json['sender'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'content': content,
      'sender': sender,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}

class BotMessage {
  final String? content;
  final String? sender;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  BotMessage({
    this.content,
    this.sender,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory BotMessage.fromJson(Map<String, dynamic> json) {
    return BotMessage(
      content: json['content'],
      sender: json['sender'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
