// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_locations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationsResponse _$SearchLocationsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchLocationsResponse(
      availableRides: (json['availableRides'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AvailableRide.fromJson(e as Map<String, dynamic>))
          .toList(),
      fareAmounts: (json['fareAmounts'] as List<dynamic>?)
          ?.map((e) => FareAmount.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SearchLocationsResponseToJson(
        SearchLocationsResponse instance) =>
    <String, dynamic>{
      'availableRides': instance.availableRides,
      'fareAmounts': instance.fareAmounts,
      'message': instance.message,
    };

AvailableRide _$AvailableRideFromJson(Map<String, dynamic> json) =>
    AvailableRide(
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

Map<String, dynamic> _$AvailableRideToJson(AvailableRide instance) =>
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

FareAmount _$FareAmountFromJson(Map<String, dynamic> json) => FareAmount(
      rideCategoryName: json['rideCategoryName'] as String?,
      fare: (json['fare'] as num?)?.toDouble(),
      tripDuration: (json['tripDuration'] as num?)?.toInt(),
      distanceToDropOff: (json['distanceToDropOff'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FareAmountToJson(FareAmount instance) =>
    <String, dynamic>{
      'rideCategoryName': instance.rideCategoryName,
      'fare': instance.fare,
      'tripDuration': instance.tripDuration,
      'distanceToDropOff': instance.distanceToDropOff,
    };
