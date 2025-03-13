import 'package:json_annotation/json_annotation.dart';

part 'save_destination_response.g.dart';

@JsonSerializable()
class SaveDestinationResponse {
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

  SaveDestinationResponse({
    this.id,
    this.name,
    this.addressName,
    this.latitude,
    this.longitude,
  });

  factory SaveDestinationResponse.fromJson(Map<String, dynamic> json) => _$SaveDestinationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveDestinationResponseToJson(this);
}
