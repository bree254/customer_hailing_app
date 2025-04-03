// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareTripResponse _$ShareTripResponseFromJson(Map<String, dynamic> json) =>
    ShareTripResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShareTripResponseToJson(ShareTripResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      shareableLink: json['shareableLink'] as String?,
      expiry: json['expiry'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'shareableLink': instance.shareableLink,
      'expiry': instance.expiry,
    };
