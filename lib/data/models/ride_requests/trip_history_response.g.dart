// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripHistoryResponse _$TripHistoryResponseFromJson(Map<String, dynamic> json) =>
    TripHistoryResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$TripHistoryResponseToJson(
        TripHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
