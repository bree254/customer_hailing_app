import 'package:json_annotation/json_annotation.dart';

part 'trip_details_response.g.dart';

@JsonSerializable()
class TripDetailsResponse {
  @JsonKey(name: "tripId")
  String? tripId;
  @JsonKey(name: "driver")
  Driver? driver;
  @JsonKey(name: "customer")
  Customer? customer;
  @JsonKey(name: "tripStatus")
  String? tripStatus;
  @JsonKey(name: "tripDetails")
  TripDetails? tripDetails;
  @JsonKey(name: "paymentDetails")
  dynamic paymentDetails;
  @JsonKey(name: "polylineRoute")
  String? polylineRoute;

  TripDetailsResponse({
    this.tripId,
    this.driver,
    this.customer,
    this.tripStatus,
    this.tripDetails,
    this.paymentDetails,
    this.polylineRoute,
  });

  factory TripDetailsResponse.fromJson(Map<String, dynamic> json) => _$TripDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailsResponseToJson(this);
}

@JsonSerializable()
class Customer {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "profileUrl")
  String? profileUrl;
  @JsonKey(name: "avgRating")
  int? avgRating;
  @JsonKey(name: "departmentId")
  List<String>? departmentId;
  @JsonKey(name: "orgId")
  List<String>? orgId;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.profileUrl,
    this.avgRating,
    this.departmentId,
    this.orgId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

@JsonSerializable()
class Driver {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "profileUrl")
  dynamic profileUrl;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "rideCategory")
  dynamic rideCategory;
  @JsonKey(name: "makeAndModel")
  String? makeAndModel;
  @JsonKey(name: "numberPlate")
  String? numberPlate;
  @JsonKey(name: "fleetId")
  dynamic fleetId;
  @JsonKey(name: "rating")
  int? rating;

  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.profileUrl,
    this.phoneNumber,
    this.rideCategory,
    this.makeAndModel,
    this.numberPlate,
    this.fleetId,
    this.rating,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}

@JsonSerializable()
class TripDetails {
  @JsonKey(name: "pickupLocation")
  Location? pickupLocation;
  @JsonKey(name: "dropOffLocation")
  Location? dropOffLocation;
  @JsonKey(name: "vehicleCategory")
  dynamic vehicleCategory;
  @JsonKey(name: "estimatedDistance")
  double? estimatedDistance;
  @JsonKey(name: "estimatedDuration")
  int? estimatedDuration;
  @JsonKey(name: "estimatedFare")
  double? estimatedFare;
  @JsonKey(name: "discount")
  dynamic discount;
  @JsonKey(name: "totalFare")
  dynamic totalFare;
  @JsonKey(name: "status")
  dynamic status;
  @JsonKey(name: "tripType")
  dynamic tripType;
  @JsonKey(name: "tripDate")
  dynamic tripDate;
  @JsonKey(name: "tripTime")
  dynamic tripTime;
  @JsonKey(name: "dropOffTime")
  dynamic dropOffTime;

  TripDetails({
    this.pickupLocation,
    this.dropOffLocation,
    this.vehicleCategory,
    this.estimatedDistance,
    this.estimatedDuration,
    this.estimatedFare,
    this.discount,
    this.totalFare,
    this.status,
    this.tripType,
    this.tripDate,
    this.tripTime,
    this.dropOffTime,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) => _$TripDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailsToJson(this);
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
