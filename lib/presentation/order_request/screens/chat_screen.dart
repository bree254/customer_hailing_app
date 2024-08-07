import 'package:customer_hailing/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [
    {
      'text':
          'Hey, I\'m using Taxi app. I\'m in a white Mazda Demio, number plate: KCZ 1234 travelling from GPO stage, Kenyatta Avenue to Movenpick residences Nairobi. You can track my trip here.',
      'sender': 'Me'
    }
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {'text': text, 'sender': 'Me'});
      });
      _controller.clear();
    }
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
                const Expanded(
                  child: Text(
                    'Alejandro',
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message['text']!, message['sender']!);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, String sender) {
    final isMe = sender == 'Me';
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              child: Text(sender[0]),
              backgroundColor: chatIcons,
            ),
          SizedBox(width: 8.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            constraints: BoxConstraints(maxWidth: 250.0),
            decoration: BoxDecoration(
              color: isMe ? senderColor : disabledButtonGrey,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
// The message input field
  Widget _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.add_photo_alternate_outlined,
              color: chatIcons,
              size: 24,
            ),
          ),
          SizedBox(width: 5,),
          Container(
            width: 210,
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
            decoration: ShapeDecoration(
              color: senderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
              ),
            ),
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Chat message',
                hintStyle: const TextStyle(
                  color: chatIcons,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          child: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: chatIcons,
                        size: 24,
                      )),
                      GestureDetector(
                          child: const Icon(
                        Icons.mic_none_rounded,
                        size: 24,
                        color: chatIcons,
                      )),
                    ]),
              ),
            ),
          ),
          SizedBox(width: 5,),
          GestureDetector(
            onTap: () => _sendMessage(_controller.text),
            child: Icon(
              Icons.send,
              color: chatIcons,
            ),
          ),
        ],
      ),
    );
  }
}
