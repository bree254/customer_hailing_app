// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_sign_up_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailSignUpResponse _$EmailSignUpResponseFromJson(Map<String, dynamic> json) =>
    EmailSignUpResponse(
      sub: json['sub'] as String?,
      confirmed: json['confirmed'] as bool?,
      destination: json['destination'] as String?,
      deliveryMedium: json['deliveryMedium'] as String?,
      attributeName: json['attributeName'] as String?,
    );

Map<String, dynamic> _$EmailSignUpResponseToJson(
        EmailSignUpResponse instance) =>
    <String, dynamic>{
      'sub': instance.sub,
      'confirmed': instance.confirmed,
      'destination': instance.destination,
      'deliveryMedium': instance.deliveryMedium,
      'attributeName': instance.attributeName,
    };
