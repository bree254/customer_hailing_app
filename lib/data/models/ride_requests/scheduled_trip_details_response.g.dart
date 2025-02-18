// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_trip_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledTripDetailsResponse _$ScheduledTripDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ScheduledTripDetailsResponse(
      pickupLocation: json['pickupLocation'] == null
          ? null
          : Location.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropOffLocation: json['dropOffLocation'] == null
          ? null
          : Location.fromJson(json['dropOffLocation'] as Map<String, dynamic>),
      vehicleCategory: json['vehicleCategory'] as String?,
      scheduledTime: json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String),
      estimatedFare: (json['estimatedFare'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScheduledTripDetailsResponseToJson(
        ScheduledTripDetailsResponse instance) =>
    <String, dynamic>{
      'pickupLocation': instance.pickupLocation,
      'dropOffLocation': instance.dropOffLocation,
      'vehicleCategory': instance.vehicleCategory,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
      'estimatedFare': instance.estimatedFare,
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
