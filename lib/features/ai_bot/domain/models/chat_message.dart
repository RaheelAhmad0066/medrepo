class ChatMessage {
  final String role; // 'user' or 'assistant'
  final String content;
  final Map<String, dynamic>? action; // Extracted <action> payload
  final DateTime timestamp;

  ChatMessage({
    required this.role,
    required this.content,
    this.action,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get isUser => role == 'user';
  bool get hasAction => action != null;

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
