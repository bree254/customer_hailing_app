import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'I was overcharged for my ride.',
      'sender': 'Me',
      'timestamp': DateTime(2024, 1, 11, 15, 30) // Example date and time
    }
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text, {String sender = 'Me'}) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {
          'text': text,
          'sender': sender,
          'timestamp': DateTime.now(),
        });
      });
      _controller.clear();

      // Automatically simulate a reply from the driver after a short delay
      if (sender == 'Me') {
        Future.delayed(Duration(seconds: 2), () {
          _sendReceiverMessage();
        });
      }
    }
  }

  void _sendReceiverMessage() {
    setState(() {
      _messages.insert(0, {
        'text': 'Hi John Doe! Got an issue? Were ready to assist you!',
        'sender': 'Support', // Specify the receiver
        'timestamp': DateTime.now(),
      });
    });
  }
  String _formatDateTime(DateTime timestamp) {
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
                    Icons.arrow_back_ios_new_outlined,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
               Icon(Icons.headset_mic_sharp,color: primaryColor,),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chat Support',
                          style: TextStyle(
                            color: Color(0xFF434343),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Online',
                          style: TextStyle(
                            color: Color(0xFF0E9F6E),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    Get.toNamed(AppRoutes.outgoingCalls);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: const Icon(
                        Icons.phone_rounded,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFAFAFA),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessage(message['text']!, message['sender']!,
                      message['timestamp']! as DateTime);
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
                decoration: ShapeDecoration(
                  color: isMe ? primaryColor : Colors.white,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.only(
                      topLeft: isMe ? const Radius.circular(10) : const Radius.circular(10),
                      topRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Color(0xFFFAFAFA) :Color(0xFF313942),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      //height: 60.0,
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 330,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 16),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Type here...',
                hintStyle: TextStyle(
                  color: chatIcons,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                setState(
                        () {}); // Trigger a rebuild to show/hide the send button
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () => _sendMessage(_controller.text),
            child: Container(
                width: 44,
                height: 44,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFF7145D6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
