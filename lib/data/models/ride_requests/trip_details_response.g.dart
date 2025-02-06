// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsResponse _$TripDetailsResponseFromJson(Map<String, dynamic> json) =>
    TripDetailsResponse(
      tripId: json['tripId'] as String?,
      driverId: json['driverId'],
      customerId: json['customerId'] as String?,
      tripStatus: json['tripStatus'] as String?,
      pickupLocation: json['pickupLocation'] == null
          ? null
          : Location.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropOffLocation: json['dropOffLocation'] == null
          ? null
          : Location.fromJson(json['dropOffLocation'] as Map<String, dynamic>),
      estimatedDistance: (json['estimatedDistance'] as num?)?.toInt(),
      estimatedFare: (json['estimatedFare'] as num?)?.toDouble(),
      discount: json['discount'],
      totalFare: json['totalFare'],
      route: json['route'] as List<dynamic>?,
      paymentDetails: json['paymentDetails'],
    );

Map<String, dynamic> _$TripDetailsResponseToJson(
        TripDetailsResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'driverId': instance.driverId,
      'customerId': instance.customerId,
      'tripStatus': instance.tripStatus,
      'pickupLocation': instance.pickupLocation,
      'dropOffLocation': instance.dropOffLocation,
      'estimatedDistance': instance.estimatedDistance,
      'estimatedFare': instance.estimatedFare,
      'discount': instance.discount,
      'totalFare': instance.totalFare,
      'route': instance.route,
      'paymentDetails': instance.paymentDetails,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      address: json['address'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'address': instance.address,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
