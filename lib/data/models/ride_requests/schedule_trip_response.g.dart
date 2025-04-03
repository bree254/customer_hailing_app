// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTripResponse _$ScheduleTripResponseFromJson(
        Map<String, dynamic> json) =>
    ScheduleTripResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$ScheduleTripResponseToJson(
        ScheduleTripResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
