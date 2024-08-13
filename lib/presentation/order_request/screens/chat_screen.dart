import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String ? _profiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profiles= Get.arguments;
  }
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey, I\'m using Taxi app. I\'m in a white Mazda Demio, number plate: KCZ 1234 travelling from GPO stage, Kenyatta Avenue to Movenpick residences Nairobi. You can track my trip here.',
      'sender': 'Me',
      'timestamp': DateTime(2024, 1, 11, 15, 30) // Example date and time
    }
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {'text': text, 'sender': 'Me','timestamp': DateTime.now(),});
      });
      _controller.clear();
    }
  }
  String _formatDateTime(DateTime timestamp) {
    // You can use the intl package for more advanced formatting
    return DateFormat('EEEE, MMM d, hh:mm a').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                 Expanded(
                  child: Text(
                    _profiles!,
                    style: TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessage(message['text']!, message['sender']!, message['timestamp']! as DateTime);
                },
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
  Widget _buildMessage(String text, String sender, DateTime timestamp) {
    final isMe = sender == 'Me';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            _formatDateTime(timestamp), // Format the date and time
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                CircleAvatar(
                  backgroundColor: chatIcons,
                  child: Text(sender[0]),
                ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                constraints: const BoxConstraints(maxWidth: 250.0),
                decoration: BoxDecoration(
                  color: isMe ? senderColor : disabledButtonGrey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }

// The message input field
  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 60.0,
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.add_circle_outline,
              color: chatIcons,
              size: 24,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.add_photo_alternate_outlined,
              color: chatIcons,
              size: 24,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 17),
              decoration: ShapeDecoration(
                color: senderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Chat message',
                        hintStyle: TextStyle(
                          color: chatIcons,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {}); // Trigger a rebuild to show/hide the send button
                      },
                    ),
                  ),
                  if (_controller.text.isEmpty) ...[
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: chatIcons,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.mic_none_rounded,
                        size: 24,
                        color: chatIcons,
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: () => _sendMessage(_controller.text),
                      child: const Icon(
                        Icons.send,
                        color: chatIcons,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
