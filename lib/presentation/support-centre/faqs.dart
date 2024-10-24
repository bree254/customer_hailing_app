import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final questions = [
    {
      'question': 'How do I add card payments?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'Can I schedule a ride in advance?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'How do I track my drivers location?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'How do I apply a promo code?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'What if my driver cancels the ride?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'What if my driver cancels the ride?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },
    {
      'question': 'How do I change or cancel my booking?',
      'answer': 'Click on the hamburger menu from the homepage, select payments from the side bar and click on, “Add new payment method.”',
    },



  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Frequently Asked Questions (FAQ)',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index]['question'];
            final answer = questions[index]['answer'];
            return Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.grey[100], // Set the divider color for this tile
              ),
              child: ExpansionTile(
                title: Text(
                  question!,
                  style: const TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),),
                trailing: const Icon(Icons.arrow_drop_down),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      answer!,
                      style: const TextStyle(
                      color: Color(0xFF434343),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
