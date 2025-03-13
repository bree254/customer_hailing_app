// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequent_destinations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrequentDestinationsResponse _$FrequentDestinationsResponseFromJson(
        Map<String, dynamic> json) =>
    FrequentDestinationsResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FrequentDestinationsResponseToJson(
        FrequentDestinationsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String?,
      name: json['name'],
      addressName: json['addressName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addressName': instance.addressName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
