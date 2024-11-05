import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageDriverScreen extends StatefulWidget {
  const MessageDriverScreen({super.key});

  @override
  State<MessageDriverScreen> createState() => _MessageDriverScreenState();
}

class _MessageDriverScreenState extends State<MessageDriverScreen> {

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hi, are you on your way?',
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
        Future.delayed(const Duration(seconds: 2), () {
          _sendReceiverMessage();
        });
      }
    }
  }

  void _sendReceiverMessage() {
    setState(() {
      _messages.insert(0, {
        'text': 'Hi, yes I’m on my way \nJust stopped to get some fuel.',
        'sender': 'Driver', // Specify the receiver
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
                Image.asset(width: 40, height: 40, 'assets/images/driver.png'),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'James Smith',
                          style: AppTextStyles.bodySmallBold,
                        ),
                        Text(
                          'Online',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: onlineText,
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
                        side: const BorderSide(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
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
        color: const Color(0xFFFAFAFA),
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
            style: AppTextStyles.bodySmall,
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
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(
                    text,
                  style: AppTextStyles.text14Black400.copyWith(
                  color: isMe ?  whiteTextColor :blackTextColor,
                ),
              ),
              )
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
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      //height: 60.0,
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 320.h,
            height: 44.v,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Type here...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: chatIcons,
                ),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                setState(
                    () {}); // Trigger a rebuild to show/hide the send button
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () => _sendMessage(_controller.text),
            child: Container(
                width: 44,
                height: 44,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7145D6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
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
