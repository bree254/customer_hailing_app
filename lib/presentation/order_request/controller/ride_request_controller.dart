import 'package:get/get.dart';
import '../models/destination.dart';

class RideRequestController extends GetxController {
  var destination = ''.obs;
  var destinations = <Destination>[].obs;

  void setDestination(String destination) {
    this.destination.value = destination;
  }

  void addDestination(Destination destination) {
    destinations.add(destination);
  }
}
