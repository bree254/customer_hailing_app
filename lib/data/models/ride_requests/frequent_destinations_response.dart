import 'package:json_annotation/json_annotation.dart';

part 'frequent_destinations_response.g.dart';

@JsonSerializable()
class FrequentDestinationsResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  FrequentDestinationsResponse({
    this.message,
    this.data,
  });

  factory FrequentDestinationsResponse.fromJson(Map<String, dynamic> json) => _$FrequentDestinationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FrequentDestinationsResponseToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  dynamic name;
  @JsonKey(name: "addressName")
  String? addressName;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;

  Datum({
    this.id,
    this.name,
    this.addressName,
    this.latitude,
    this.longitude,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
