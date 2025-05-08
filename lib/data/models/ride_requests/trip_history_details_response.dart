import 'package:json_annotation/json_annotation.dart';

part 'trip_history_details_response.g.dart';

@JsonSerializable()
class TripHistoryDetailsResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  TripHistoryDetailsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TripHistoryDetailsResponse.fromJson(Map<String, dynamic> json) => _$TripHistoryDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripHistoryDetailsResponseToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "driver")
  Driver? driver;
  @JsonKey(name: "fare")
  String? fare;
  @JsonKey(name: "rideCategory")
  String? rideCategory;
  @JsonKey(name: "origin")
  String? origin;
  @JsonKey(name: "destination")
  String? destination;
  @JsonKey(name: "startTime")
  DateTime? startTime;
  @JsonKey(name: "endTime")
  DateTime? endTime;
  @JsonKey(name: "paymentMethod")
  String? paymentMethod;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "polylinePoints")
  String? polylinePoints;

  Datum({
    this.driver,
    this.fare,
    this.rideCategory,
    this.origin,
    this.destination,
    this.startTime,
    this.endTime,
    this.paymentMethod,
    this.status,
    this.polylinePoints,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
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
  @JsonKey(name: "rideCategoryIcon")
  dynamic rideCategoryIcon;
  @JsonKey(name: "makeAndModel")
  String? makeAndModel;
  @JsonKey(name: "numberPlate")
  String? numberPlate;
  @JsonKey(name: "fleetId")
  dynamic fleetId;
  @JsonKey(name: "rating")
  double? rating;
  @JsonKey(name: "firebaseToken")
  String? firebaseToken;
  @JsonKey(name: "platform")
  String? platform;

  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.profileUrl,
    this.phoneNumber,
    this.rideCategory,
    this.rideCategoryIcon,
    this.makeAndModel,
    this.numberPlate,
    this.fleetId,
    this.rating,
    this.firebaseToken,
    this.platform,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
