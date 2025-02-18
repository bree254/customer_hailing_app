import 'package:json_annotation/json_annotation.dart';

part 'scheduled_trips_response.g.dart';

@JsonSerializable()
class ScheduledTripsResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "pickupLocation")
  Location? pickupLocation;
  @JsonKey(name: "dropOffLocation")
  Location? dropOffLocation;
  @JsonKey(name: "scheduledTime")
  DateTime? scheduledTime;

  ScheduledTripsResponse({
    this.id,
    this.pickupLocation,
    this.dropOffLocation,
    this.scheduledTime,
  });

  factory ScheduledTripsResponse.fromJson(Map<String, dynamic> json) => _$ScheduledTripsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduledTripsResponseToJson(this);
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
