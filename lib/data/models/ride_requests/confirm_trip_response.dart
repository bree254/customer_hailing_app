import 'package:json_annotation/json_annotation.dart';

part 'confirm_trip_response.g.dart';

@JsonSerializable()
class ConfirmTripResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ConfirmTripResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ConfirmTripResponse.fromJson(Map<String, dynamic> json) => _$ConfirmTripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmTripResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "requestId")
  String? requestId;

  Data({
    this.requestId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  // @override
  // String toString() {
  //   return 'Data{requestId: $requestId}';
  // }
}
