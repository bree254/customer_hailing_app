// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsUpdatesResponse _$LocationsUpdatesResponseFromJson(
        Map<String, dynamic> json) =>
    LocationsUpdatesResponse(
      driverId: json['driverId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      tripId: json['tripId'] as String?,
      vehicleDetails: json['vehicleDetails'] == null
          ? null
          : VehicleDetails.fromJson(
              json['vehicleDetails'] as Map<String, dynamic>),
      carIcon: json['carIcon'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      rideCategory: json['rideCategory'] as String?,
      speed: (json['speed'] as num?)?.toInt(),
      accuracy: (json['accuracy'] as num?)?.toInt(),
      distanceTravelled: (json['distanceTravelled'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocationsUpdatesResponseToJson(
        LocationsUpdatesResponse instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'tripId': instance.tripId,
      'vehicleDetails': instance.vehicleDetails,
      'carIcon': instance.carIcon,
      'rating': instance.rating,
      'rideCategory': instance.rideCategory,
      'speed': instance.speed,
      'accuracy': instance.accuracy,
      'distanceTravelled': instance.distanceTravelled,
    };

VehicleDetails _$VehicleDetailsFromJson(Map<String, dynamic> json) =>
    VehicleDetails(
      makeAndModel: json['makeAndModel'] as String?,
      color: json['color'] as String?,
      engineCapacity: (json['engineCapacity'] as num?)?.toInt(),
      numberPlate: json['numberPlate'] as String?,
    );

Map<String, dynamic> _$VehicleDetailsToJson(VehicleDetails instance) =>
    <String, dynamic>{
      'makeAndModel': instance.makeAndModel,
      'color': instance.color,
      'engineCapacity': instance.engineCapacity,
      'numberPlate': instance.numberPlate,
    };
