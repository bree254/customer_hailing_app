// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_destination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveDestinationResponse _$SaveDestinationResponseFromJson(
        Map<String, dynamic> json) =>
    SaveDestinationResponse(
      id: json['id'] as String?,
      name: json['name'],
      addressName: json['addressName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SaveDestinationResponseToJson(
        SaveDestinationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addressName': instance.addressName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
