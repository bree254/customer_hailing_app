import 'package:json_annotation/json_annotation.dart';

part 'driver_locations_response.g.dart';

@JsonSerializable()
class DriverLocationsResponse {
  @JsonKey(name: "driverId")
  String? driverId;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "vehicleDetails")
  VehicleDetails? vehicleDetails;
  @JsonKey(name: "carIcon")
  String? carIcon;
  @JsonKey(name: "rating")
  int? rating;
  @JsonKey(name: "rideCategory")
  String? rideCategory;

  DriverLocationsResponse({
    this.driverId,
    this.latitude,
    this.longitude,
    this.vehicleDetails,
    this.carIcon,
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
  @JsonKey(name: "numberPlate")
  String? numberPlate;

  VehicleDetails({
    this.makeAndModel,
    this.color,
    this.engineCapacity,
    this.numberPlate,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => _$VehicleDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDetailsToJson(this);
}
