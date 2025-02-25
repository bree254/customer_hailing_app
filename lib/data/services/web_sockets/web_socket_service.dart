import 'dart:convert';

import 'package:customer_hailing/data/models/ride_requests/driver_locations_response.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService{
late StompClient stompClient;
// late StompConnectStatus stompConnectStatus;
late final Function (List<DriverLocationsResponse>) onDriverLocationsReceived;
//final String url = 'wss://yasil-rides.cymelle.com/ws';
final String url = 'wss://rides.yasil.co.ke/ws';

WebSocketService({required this.onDriverLocationsReceived});

void connect(){
  stompClient = StompClient(
    config: StompConfig(
      url: url,
      onConnect: onConnect,
      onWebSocketError: onWebSocketError,
      onDisconnect: onDisconnect,
      onDebugMessage: (String message) {
        print('Debug: $message');
      },
      onStompError: (StompFrame frame) {
        print('Stomp error: ${frame.body}');
      },
    ),
  );
  stompClient.activate();
  }

  void onConnect(StompFrame frame) {
    print('Connected');
   subscribeToDriverLocationTopic(frame);
  }

  void subscribeToDriverLocationTopic(StompFrame frame) {
    print('Connected');
    stompClient.subscribe(
      destination: '/topic/locations',
      callback: onDriverLocationsUpdated,
    );
  }

  // void onDriverLocationsUpdated(StompFrame frame) {
  //   var data = jsonDecode(frame.body!);
  //
  //   if (data is Map<String, dynamic>) {
  //     print('web data: $data');
  //     List<dynamic> driverList = data['driverLocations'] ?? [];
  //     List<DriverLocationsResponse> driverLocations = driverList.map((driver) => DriverLocationsResponse.fromJson(driver)).toList();
  //     onDriverLocationsReceived(driverLocations);
  //   } else {
  //     print('Unexpected data format');
  //   }
  // }

  void onDriverLocationsUpdated(StompFrame frame) {
    var data = jsonDecode(frame.body!);

    if (data is Map<String, dynamic>) {
      print('web data: $data');
      DriverLocationsResponse driverLocation = DriverLocationsResponse.fromJson(data);
      onDriverLocationsReceived([driverLocation]);
    } else {
      print('Unexpected data format');
    }
  }

  void onWebSocketError(error) {
    print('WebSocket Error: $error');
  }
  void onDisconnect(StompFrame frame) {
    print('Disconnected');
  }

  void disconnect(){
    stompClient.deactivate();
  }

}