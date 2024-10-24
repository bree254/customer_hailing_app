import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/support-centre/widgets/chat_list_widget.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';
class ChatLists extends StatefulWidget {
  const ChatLists({super.key});

  @override
  State<ChatLists> createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatLists> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know... ",  time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know... ", time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know...",  time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know... ", time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know...",  time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know...", time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know...", time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),
    ChatUsers(name: "I was overcharged for my ride", messageText: "I apologise for this inconvenience, we know...",  time: "02:00pm", iconData: const Icon(Icons.headset_mic_outlined,color: primaryColor)),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),

      body: chatUsers.isEmpty
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 58),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'You have no previous chats with support',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Tap on, “Start New Chat” below to get assistance from our support team',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: formTextLabelColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            CustomElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.chatSupportScreen);
              },
              text: 'Start New Chat',
              buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: whiteTextColor,
                side: const BorderSide(color: primaryColor),
                elevation: 0,
              ),
              buttonTextStyle: const TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          :
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.separated(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return MessageWidget(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  iconData: chatUsers[index].iconData,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.grey[100],);
            },
            ),
          ],
        ),
      ),


    );
  }
}

class ChatUsers{
  String name;
  String messageText;
  Widget iconData;
  String time;
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.iconData,
    required this.time});
}