import 'package:json_annotation/json_annotation.dart';

part 'locations_update_response.g.dart';

@JsonSerializable()
class LocationsUpdatesResponse {
  @JsonKey(name: "driverId")
  String? driverId;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "tripId")
  String? tripId;
  @JsonKey(name: "vehicleDetails")
  VehicleDetails? vehicleDetails;
  @JsonKey(name: "carIcon")
  String? carIcon;
  @JsonKey(name: "rating")
  int? rating;
  @JsonKey(name: "rideCategory")
  String? rideCategory;
  @JsonKey(name: "speed")
  int? speed;
  @JsonKey(name: "accuracy")
  int? accuracy;
  @JsonKey(name: "distanceTravelled")
  int? distanceTravelled;

  LocationsUpdatesResponse({
    this.driverId,
    this.latitude,
    this.longitude,
    this.tripId,
    this.vehicleDetails,
    this.carIcon,
    this.rating,
    this.rideCategory,
    this.speed,
    this.accuracy,
    this.distanceTravelled,
  });

  factory LocationsUpdatesResponse.fromJson(Map<String, dynamic> json) => _$LocationsUpdatesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsUpdatesResponseToJson(this);
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
