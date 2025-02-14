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
  @JsonKey(name: "driverId")
  String? driverId;
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
    this.driverId,
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
