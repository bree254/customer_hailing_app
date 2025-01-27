// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_locations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLocationsResponse _$DriverLocationsResponseFromJson(
        Map<String, dynamic> json) =>
    DriverLocationsResponse(
      id: json['id'],
      driverId: json['driverId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      status: json['status'] as String?,
      vehicleDetails: json['vehicleDetails'] == null
          ? null
          : VehicleDetails.fromJson(
              json['vehicleDetails'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toInt(),
      rideCategory: json['rideCategory'] as String?,
    );

Map<String, dynamic> _$DriverLocationsResponseToJson(
        DriverLocationsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driverId': instance.driverId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': instance.status,
      'vehicleDetails': instance.vehicleDetails,
      'rating': instance.rating,
      'rideCategory': instance.rideCategory,
    };

VehicleDetails _$VehicleDetailsFromJson(Map<String, dynamic> json) =>
    VehicleDetails(
      makeAndModel: json['makeAndModel'] as String?,
      color: json['color'] as String?,
      engineCapacity: (json['engineCapacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VehicleDetailsToJson(VehicleDetails instance) =>
    <String, dynamic>{
      'makeAndModel': instance.makeAndModel,
      'color': instance.color,
      'engineCapacity': instance.engineCapacity,
    };
