// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmTripResponse _$ConfirmTripResponseFromJson(Map<String, dynamic> json) =>
    ConfirmTripResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmTripResponseToJson(
        ConfirmTripResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'requestId': instance.requestId,
    };
