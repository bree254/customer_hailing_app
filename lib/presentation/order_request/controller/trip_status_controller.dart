 import 'package:customer_hailing/core/app_export.dart';

enum TripStatus{
  onTheWay,
   arrived,
   heading
 }
 class TripStatusController extends GetxController{
  var currentTripStatus = TripStatus.onTheWay.obs;


 }