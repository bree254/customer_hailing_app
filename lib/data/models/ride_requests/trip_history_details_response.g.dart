// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripHistoryDetailsResponse _$TripHistoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    TripHistoryDetailsResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripHistoryDetailsResponseToJson(
        TripHistoryDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      driverId: json['driverId'] as String?,
      fare: json['fare'] as String?,
      rideCategory: json['rideCategory'] as String?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      paymentMethod: json['paymentMethod'] as String?,
      status: json['status'] as String?,
      polylinePoints: json['polylinePoints'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'driverId': instance.driverId,
      'fare': instance.fare,
      'rideCategory': instance.rideCategory,
      'origin': instance.origin,
      'destination': instance.destination,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'polylinePoints': instance.polylinePoints,
    };
