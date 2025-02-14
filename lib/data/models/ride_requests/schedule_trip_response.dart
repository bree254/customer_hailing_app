import 'package:json_annotation/json_annotation.dart';

part 'schedule_trip_response.g.dart';

@JsonSerializable()
class ScheduleTripResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  ScheduleTripResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ScheduleTripResponse.fromJson(Map<String, dynamic> json) => _$ScheduleTripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTripResponseToJson(this);
}
