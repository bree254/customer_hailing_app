import 'package:json_annotation/json_annotation.dart';

part 'scheduled_trip_details_response.g.dart';

@JsonSerializable()
class ScheduledTripDetailsResponse {
  @JsonKey(name: "pickupLocation")
  Location? pickupLocation;
  @JsonKey(name: "dropOffLocation")
  Location? dropOffLocation;
  @JsonKey(name: "vehicleCategory")
  String? vehicleCategory;
  @JsonKey(name: "scheduledTime")
  DateTime? scheduledTime;
  @JsonKey(name: "estimatedFare")
  int? estimatedFare;

  ScheduledTripDetailsResponse({
    this.pickupLocation,
    this.dropOffLocation,
    this.vehicleCategory,
    this.scheduledTime,
    this.estimatedFare,
  });

  factory ScheduledTripDetailsResponse.fromJson(Map<String, dynamic> json) => _$ScheduledTripDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduledTripDetailsResponseToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "address")
  String? address;

  Location({
    this.latitude,
    this.longitude,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
