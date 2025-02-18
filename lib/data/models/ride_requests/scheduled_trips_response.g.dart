// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_trips_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledTripsResponse _$ScheduledTripsResponseFromJson(
        Map<String, dynamic> json) =>
    ScheduledTripsResponse(
      id: json['id'] as String?,
      pickupLocation: json['pickupLocation'] == null
          ? null
          : Location.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropOffLocation: json['dropOffLocation'] == null
          ? null
          : Location.fromJson(json['dropOffLocation'] as Map<String, dynamic>),
      scheduledTime: json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
    );

Map<String, dynamic> _$ScheduledTripsResponseToJson(
        ScheduledTripsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pickupLocation': instance.pickupLocation,
      'dropOffLocation': instance.dropOffLocation,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
