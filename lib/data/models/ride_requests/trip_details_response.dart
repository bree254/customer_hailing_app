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
  @JsonKey(name: "route")
  List<dynamic>? route;

  TripDetailsResponse({
    this.tripId,
    this.driver,
    this.customer,
    this.tripStatus,
    this.tripDetails,
    this.paymentDetails,
    this.route,
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

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
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
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "vehicleCategory")
  dynamic vehicleCategory;
  @JsonKey(name: "makeAndModel")
  String? makeAndModel;
  @JsonKey(name: "numberPlate")
  dynamic numberPlate;
  @JsonKey(name: "rating")
  int? rating;

  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.vehicleCategory,
    this.makeAndModel,
    this.numberPlate,
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
  int? estimatedDistance;
  @JsonKey(name: "estimatedFare")
  double? estimatedFare;
  @JsonKey(name: "discount")
  dynamic discount;
  @JsonKey(name: "totalFare")
  dynamic totalFare;

  TripDetails({
    this.pickupLocation,
    this.dropOffLocation,
    this.vehicleCategory,
    this.estimatedDistance,
    this.estimatedFare,
    this.discount,
    this.totalFare,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) => _$TripDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TripDetailsToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;

  Location({
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
