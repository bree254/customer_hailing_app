import 'package:customer_hailing/presentation/order_request/models/ride.dart';

import 'Profiles.dart';
import 'destination.dart';

class MyData {
  static List<Destination> destinations = [
    Destination(address: 'The Hub Karen', location: 'Nairobi,kenya'),
    Destination(address: 'GPO Stage Kenyatta Avenue', location: 'Nairobi,kenya'),
    Destination(address: 'Sarit Center', location: 'Nairobi,kenya'),
    Destination(address: 'Jamhuri Shopping center', location: 'Nairobi,kenya'),
    Destination(address: 'Blue Hills Academy', location: 'Nairobi,kenya'),
    Destination(address: 'The Hub Karen', location: 'Nairobi,kenya'),
    Destination(address: 'GPO Stage Kenyatta Avenue', location: 'Nairobi,kenya'),
    Destination(address: 'Sarit Center', location: 'Nairobi,kenya'),
    Destination(address: 'Jamhuri Shopping center', location: 'Nairobi,kenya'),
    Destination(address: 'Blue Hills Academy', location: 'Nairobi,kenya'),
    Destination(address: 'The Hub Karen', location: 'Nairobi,kenya'),
    Destination(address: 'GPO Stage Kenyatta Avenue', location: 'Nairobi,kenya'),
    Destination(address: 'Sarit Center', location: 'Nairobi,kenya'),
    Destination(address: 'Jamhuri Shopping center', location: 'Nairobi,kenya'),
    Destination(address: 'Blue Hills Academy', location: 'Nairobi,kenya'),
  ];

  static List<RideRequest> requests = [
    RideRequest(
        ridetype: 'Economy',
        timeEstimate: '1 min away',
        imageUrl: 'assets/images/economy.png',
        discountedPrice: 460,
        originalprice: 580),
    RideRequest(
        ridetype: 'Boda',
        timeEstimate: '3 min away',
        imageUrl: 'assets/images/boda.png',
        discountedPrice: 180,
        originalprice: 220),
    RideRequest(
        ridetype: 'Taxi Comfort',
        timeEstimate: '5 min away',
        imageUrl: 'assets/images/economy.png',
        discountedPrice: 660,
        originalprice: 720),
  ];
  static List<ShareProfiles> profiles =[
    ShareProfiles(imageUrl: 'assets/images/alejandro.png', name: 'Alejandro'),
    ShareProfiles(imageUrl: 'assets/images/ela.png', name: 'Ela'),
    ShareProfiles(imageUrl: 'assets/images/jacinta.png', name: 'Jecinta'),
    ShareProfiles(imageUrl: 'assets/images/steve.png', name: 'Steve'),
  ];
}
