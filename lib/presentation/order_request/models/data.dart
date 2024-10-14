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
    RideRequest(
        ridetype: 'Taxi Female',
        timeEstimate: '5 min away',
        imageUrl: 'assets/images/economy.png',
        discountedPrice: 720,
        originalprice: 760),
    RideRequest(
        ridetype: 'Taxi XL',
        timeEstimate: '5 min away',
        imageUrl: 'assets/images/economy.png',
        discountedPrice: 720,
        originalprice: 1020),
  ];

  static List<ShareProfiles> profiles =[
    ShareProfiles(imageUrl: 'assets/images/alejandro.png', name: 'Alejandro'),
    ShareProfiles(imageUrl: 'assets/images/ela.png', name: 'Ela'),
    ShareProfiles(imageUrl: 'assets/images/jacinta.png', name: 'Jecinta'),
    ShareProfiles(imageUrl: 'assets/images/steve.png', name: 'Steve'),
  ];


  // Sample list of scheduled trips
   static final List<Map<String, String>> history = [
    {
      'destination': 'I&M Bank Building',
      'time': '12th August - 12:05pm ',
      'price': 'Ksh 560',
    },
    {
      'destination': 'I&M Bank Building',
      'time': '12th August - 12:05pm ',
      'price': 'Ksh 560',
    },
    {
      'destination': 'I&M Bank Building',
      'time': '12th August - 12:05pm ',
      'price': 'Ksh 560',
    },
    {
      'destination': 'I&M Bank Building',
      'time': '12th August - 12:05pm ',
      'price': 'Ksh 560',
    },
    {
      'destination': 'I&M Bank Building',
      'time': '12th August - 12:05pm ',
      'price': 'Ksh 560',
    },
    {
      'destination': 'I&M Bank Building',
      'time': '12th August - 12:05pm ',
      'price': 'Ksh 560',
    },
{
'destination': 'I&M Bank Building',
'time': '12th August - 12:05pm ',
'price': 'Ksh 560',
}
];

  static final List<Map<String, String>> trips = [
    {
      'dateTime': 'Oct 5, 2024 10:00 AM',
      'from': 'GPO Stage, Kenyatta Avenue',
      'to': 'Mövenpick Residences Nairobi',
    },
    {
      'dateTime': 'Oct 6, 2024 02:00 PM',
      'from': '789 Oak St, Metropolis',
      'to': '101 Maple St, Gotham',
    },
    // Add more trips as needed
  ];
}
