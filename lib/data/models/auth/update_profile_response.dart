import 'package:json_annotation/json_annotation.dart';

part 'update_profile_response.g.dart';

@JsonSerializable()
class UpdateProfileResponse {
  @JsonKey(name: "message")
  String? message;

  UpdateProfileResponse({
    this.message,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => _$UpdateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);
}
