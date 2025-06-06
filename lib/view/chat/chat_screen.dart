import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:research_proj/common/color_extension.dart';
import '../../models/chat_message.dart';
import '../../services/chatbot_service.dart';
import '../../common_widget/suggestion_button.dart';
import 'help_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ChatbotService _chatbotService = ChatbotService();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeChatbot();
  }

  Future<void> _initializeChatbot() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _chatbotService.initialize();

      // Add a welcome message
      setState(() {
        _messages.add(ChatMessage(
          text: 'Hello! How can I help you with your skincare concerns today?',
          isUser: false,
        ));
      });
    } catch (error) {
      print('Failed to initialize chatbot: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize chatbot: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _chatbotService.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
      ));
      _isLoading = true;
    });

    // Scroll to bottom after user message is added
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    try {
      final response = await _chatbotService.processMessage(text);

      setState(() {
        _messages.add(ChatMessage(
          text: response['response'],
          isUser: false,
          tag: response['tag'],
          confidence: response['confidence'],
        ));
        _isLoading = false;
      });

      // Scroll to bottom after bot response is added
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    } catch (error) {
      print('Error processing message: $error');
      setState(() {
        _messages.add(ChatMessage(
          text: 'Sorry, I encountered an error processing your request.',
          isUser: false,
        ));
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skincare Chatbot'),
        backgroundColor: Tcolor.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading && _messages.isEmpty
                ? Center(
                    child: SpinKitFadingCircle(
                      color: Tcolor.primary,
                      size: 50.0,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _messages.length,
                    itemBuilder: (_, int index) {
                      return _buildMessage(_messages[index]);
                    },
                  ),
          ),
          if (_isLoading && _messages.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SpinKitThreeBounce(
                    color: Tcolor.primary,
                    size: 24.0,
                  ),
                ],
              ),
            ),
          const Divider(height: 1.0),
          _buildSuggestionChips(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser)
            CircleAvatar(
              backgroundColor: Tcolor.primary,
              child: Text('Bot', style: TextStyle(color: Colors.white)),
            ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color:
                        message.isUser ? Tcolor.primary : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: message.isUser
                      ? Text(
                          message.text,
                          style: const TextStyle(color: Colors.white),
                        )
                      : AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              message.text,
                              textStyle: const TextStyle(color: Colors.black87),
                              speed: const Duration(milliseconds: 50),
                            ),
                          ],
                          totalRepeatCount: 1,
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                ),
                if (message.confidence != null && !message.isUser)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                    child: Text(
                      'Confidence: ${(message.confidence! * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (message.isUser) const SizedBox(width: 8.0),
          if (message.isUser)
            CircleAvatar(
              backgroundColor: Tcolor.secondaryText,
              child: Text('You', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChips() {
    final List<String> suggestions = [
      "How to treat dry skin?",
      "What helps with acne?",
      "Best skincare routine?",
      "Product recommendations",
      "Oily skin remedies",
      "Anti-aging tips",
      "Sun protection advice",
      "Sensitive skin care",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return SuggestionButton(
            text: suggestions[index],
            onTap: () => _handleSubmitted(suggestions[index]),
          );
        },
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
