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
      driver: json['driver'] == null
          ? null
          : Driver.fromJson(json['driver'] as Map<String, dynamic>),
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
      'driver': instance.driver,
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

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      rideCategory: json['rideCategory'],
      makeAndModel: json['makeAndModel'] as String?,
      numberPlate: json['numberPlate'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'rideCategory': instance.rideCategory,
      'makeAndModel': instance.makeAndModel,
      'numberPlate': instance.numberPlate,
      'rating': instance.rating,
    };
