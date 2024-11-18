import 'package:json_annotation/json_annotation.dart';

part 'email_sign_up_screen.g.dart';

@JsonSerializable()
class EmailSignUpResponse {
  @JsonKey(name: "sub")
  String? sub;
  @JsonKey(name: "confirmed")
  bool? confirmed;
  @JsonKey(name: "destination")
  String? destination;
  @JsonKey(name: "deliveryMedium")
  String? deliveryMedium;
  @JsonKey(name: "attributeName")
  String? attributeName;

  EmailSignUpResponse({
    this.sub,
    this.confirmed,
    this.destination,
    this.deliveryMedium,
    this.attributeName,
  });

  factory EmailSignUpResponse.fromJson(Map<String, dynamic> json) => _$EmailSignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailSignUpResponseToJson(this);
}
