// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_locations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLocationsResponse _$DriverLocationsResponseFromJson(
        Map<String, dynamic> json) =>
    DriverLocationsResponse(
      driverId: json['driverId'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      vehicleDetails: json['vehicleDetails'] == null
          ? null
          : VehicleDetails.fromJson(
              json['vehicleDetails'] as Map<String, dynamic>),
      carIcon: json['carIcon'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      rideCategory: json['rideCategory'] as String?,
    );

Map<String, dynamic> _$DriverLocationsResponseToJson(
        DriverLocationsResponse instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'vehicleDetails': instance.vehicleDetails,
      'carIcon': instance.carIcon,
      'rating': instance.rating,
      'rideCategory': instance.rideCategory,
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
