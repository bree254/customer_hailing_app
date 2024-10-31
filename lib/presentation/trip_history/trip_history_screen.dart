import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/order_request/models/data.dart';
import 'package:customer_hailing/routes/routes.dart';
import 'package:flutter/material.dart';
class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          'History',
          style: AppTextStyles.largeAppBarText,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            itemCount: MyData.history.length,
          itemBuilder: (context ,index){
            final history = MyData.history[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(height: 5,width:5,'assets/images/map_pin_outline.png'),
                  ),
                ),
                title: Text(
                  history['destination'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF555555),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history['time'] ?? '',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      history['price'] ?? '',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 69,
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration:  ShapeDecoration(
                    color: const Color(0xFFF8F2FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                        height: 10,
                        child:Image.asset(height: 10,width:10,'assets/images/rotate.png'),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Rebook',
                        style: TextStyle(
                          color: Color(0xFF1F2A37),
                          fontSize: 10,
                          fontFamily: 'BR Omny',
                          fontWeight: FontWeight.w400,
                          height: 0.20,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.historyDetails);
                },
              ),
            );


      },
        )
      ),
    );
  }
}
