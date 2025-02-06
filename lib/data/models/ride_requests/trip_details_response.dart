import 'package:json_annotation/json_annotation.dart';

part 'trip_details_response.g.dart';

@JsonSerializable()
class TripDetailsResponse {
  @JsonKey(name: "tripId")
  String? tripId;
  @JsonKey(name: "driverId")
  dynamic driverId;
  @JsonKey(name: "customerId")
  String? customerId;
  @JsonKey(name: "tripStatus")
  String? tripStatus;
  @JsonKey(name: "pickupLocation")
  Location? pickupLocation;
  @JsonKey(name: "dropOffLocation")
  Location? dropOffLocation;
  @JsonKey(name: "estimatedDistance")
  int? estimatedDistance;
  @JsonKey(name: "estimatedFare")
  double? estimatedFare;
  @JsonKey(name: "discount")
  dynamic discount;
  @JsonKey(name: "totalFare")
  dynamic totalFare;
  @JsonKey(name: "route")
  List<dynamic>? route;
  @JsonKey(name: "paymentDetails")
  dynamic paymentDetails;

  TripDetailsResponse({
    this.tripId,
    this.driverId,
    this.customerId,
    this.tripStatus,
    this.pickupLocation,
    this.dropOffLocation,
    this.estimatedDistance,
    this.estimatedFare,
    this.discount,
    this.totalFare,
    this.route,
    this.paymentDetails,
  });

  factory TripDetailsResponse.fromJson(Map<String, dynamic> json) => _$TripDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailsResponseToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "latitude")
  String? latitude;

  Location({
    this.address,
    this.longitude,
    this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
