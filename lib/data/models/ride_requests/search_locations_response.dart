import 'package:json_annotation/json_annotation.dart';

part 'search_locations_response.g.dart';

@JsonSerializable()
class SearchLocationsResponse {
  @JsonKey(name: "availableRides")
  List<AvailableRide>? availableRides;
  @JsonKey(name: "fareAmounts")
  List<FareAmount>? fareAmounts;
  @JsonKey(name: "message")
  String? message;

  SearchLocationsResponse({
    this.availableRides,
    this.fareAmounts,
    this.message,
  });

  factory SearchLocationsResponse.fromJson(Map<String, dynamic> json) => _$SearchLocationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLocationsResponseToJson(this);
}

@JsonSerializable()
class AvailableRide {
  @JsonKey(name: "driverId")
  String? driverId;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "vehicleDetails")
  VehicleDetails? vehicleDetails;
  @JsonKey(name: "rating")
  int? rating;
  @JsonKey(name: "rideCategory")
  String? rideCategory;

  AvailableRide({
    this.driverId,
    this.latitude,
    this.longitude,
    this.vehicleDetails,
    this.rating,
    this.rideCategory,
  });

  factory AvailableRide.fromJson(Map<String, dynamic> json) => _$AvailableRideFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableRideToJson(this);
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
  dynamic numberPlate;

  VehicleDetails({
    this.makeAndModel,
    this.color,
    this.engineCapacity,
    this.numberPlate,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => _$VehicleDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDetailsToJson(this);
}

@JsonSerializable()
class FareAmount {
  @JsonKey(name: "rideCategoryName")
  String? rideCategoryName;
  @JsonKey(name: "fare")
  double? fare;
  @JsonKey(name: "tripDuration")
  int? tripDuration;
  @JsonKey(name: "distanceToDropOff")
  double? distanceToDropOff;
  @JsonKey(name: "carIllustration")
  String? carIllustration;

  FareAmount({
    this.rideCategoryName,
    this.fare,
    this.tripDuration,
    this.distanceToDropOff,
    this.carIllustration,
  });

  factory FareAmount.fromJson(Map<String, dynamic> json) => _$FareAmountFromJson(json);

  Map<String, dynamic> toJson() => _$FareAmountToJson(this);
}

