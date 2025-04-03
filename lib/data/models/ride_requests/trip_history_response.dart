import 'package:json_annotation/json_annotation.dart';

part 'trip_history_response.g.dart';

@JsonSerializable()
class TripHistoryResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  TripHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TripHistoryResponse.fromJson(Map<String, dynamic> json) => _$TripHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripHistoryResponseToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "destination")
  String? destination;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "amount")
  dynamic amount;

  Datum({
    this.id,
    this.destination,
    this.date,
    this.amount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

