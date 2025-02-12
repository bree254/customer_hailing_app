import 'package:json_annotation/json_annotation.dart';

part 'trip_history_response.g.dart';

@JsonSerializable()
class TripHistoryResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  dynamic data;

  TripHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TripHistoryResponse.fromJson(Map<String, dynamic> json) => _$TripHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripHistoryResponseToJson(this);
}
