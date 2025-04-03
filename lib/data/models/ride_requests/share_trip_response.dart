import 'package:json_annotation/json_annotation.dart';

part 'share_trip_response.g.dart';

@JsonSerializable()
class ShareTripResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ShareTripResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ShareTripResponse.fromJson(Map<String, dynamic> json) => _$ShareTripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShareTripResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "shareableLink")
  String? shareableLink;
  @JsonKey(name: "expiry")
  dynamic expiry;

  Data({
    this.shareableLink,
    this.expiry,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
