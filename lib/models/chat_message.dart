class ChatMessage {
  final String text;
  final bool isUser;
  final String? tag; // Optional tag for response
  final double? confidence; // Optional confidence for response

  ChatMessage({
    required this.text,
    required this.isUser,
    this.tag,
    this.confidence,
  });
}
