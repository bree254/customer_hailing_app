// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidOtpResponse _$ValidOtpResponseFromJson(Map<String, dynamic> json) =>
    ValidOtpResponse(
      authenticationResult: json['authenticationResult'] == null
          ? null
          : AuthenticationResult.fromJson(
              json['authenticationResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidOtpResponseToJson(ValidOtpResponse instance) =>
    <String, dynamic>{
      'authenticationResult': instance.authenticationResult,
    };

AuthenticationResult _$AuthenticationResultFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResult(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthenticationResultToJson(
        AuthenticationResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
