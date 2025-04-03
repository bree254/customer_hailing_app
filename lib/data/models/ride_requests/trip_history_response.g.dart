// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripHistoryResponse _$TripHistoryResponseFromJson(Map<String, dynamic> json) =>
    TripHistoryResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripHistoryResponseToJson(
        TripHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String?,
      destination: json['destination'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      amount: json['amount'],
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'destination': instance.destination,
      'date': instance.date?.toIso8601String(),
      'amount': instance.amount,
    };
