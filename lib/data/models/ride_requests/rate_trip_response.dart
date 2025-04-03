import 'package:json_annotation/json_annotation.dart';

part 'rate_trip_response.g.dart';
@JsonSerializable()
class RateTripResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  RateTripResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RateTripResponse.fromJson(Map<String, dynamic> json) => _$RateTripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RateTripResponseToJson(this);
}
