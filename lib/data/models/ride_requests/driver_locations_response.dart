import 'package:json_annotation/json_annotation.dart';

part 'driver_locations_response.g.dart';

@JsonSerializable()
class DriverLocationsResponse {
  @JsonKey(name: "id")
  dynamic id;
  @JsonKey(name: "driverId")
  String? driverId;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "vehicleDetails")
  VehicleDetails? vehicleDetails;
  @JsonKey(name: "rating")
  int? rating;
  @JsonKey(name: "rideCategory")
  String? rideCategory;

  DriverLocationsResponse({
    this.id,
    this.driverId,
    this.latitude,
    this.longitude,
    this.status,
    this.vehicleDetails,
    this.rating,
    this.rideCategory,
  });

  factory DriverLocationsResponse.fromJson(Map<String, dynamic> json) => _$DriverLocationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverLocationsResponseToJson(this);
}

@JsonSerializable()
class VehicleDetails {
  @JsonKey(name: "makeAndModel")
  String? makeAndModel;
  @JsonKey(name: "color")
  String? color;
  @JsonKey(name: "engineCapacity")
  int? engineCapacity;

  VehicleDetails({
    this.makeAndModel,
    this.color,
    this.engineCapacity,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => _$VehicleDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDetailsToJson(this);
}
