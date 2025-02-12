// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateTripResponse _$RateTripResponseFromJson(Map<String, dynamic> json) =>
    RateTripResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$RateTripResponseToJson(RateTripResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
