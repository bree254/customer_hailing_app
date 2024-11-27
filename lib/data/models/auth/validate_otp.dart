import 'package:json_annotation/json_annotation.dart';

part 'validate_otp.g.dart';
@JsonSerializable()
class ValidOtpResponse {
  @JsonKey(name: "authenticationResult")
  AuthenticationResult? authenticationResult;

  ValidOtpResponse({
    this.authenticationResult,
  });

  factory ValidOtpResponse.fromJson(Map<String, dynamic> json) => _$ValidOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidOtpResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResult {
  @JsonKey(name: "accessToken")
  String? accessToken;
  @JsonKey(name: "refreshToken")
  String? refreshToken;
  @JsonKey(name: "expiresIn")
  int? expiresIn;

  AuthenticationResult({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory AuthenticationResult.fromJson(Map<String, dynamic> json) => _$AuthenticationResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResultToJson(this);
}