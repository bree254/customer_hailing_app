// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsResponse _$TripDetailsResponseFromJson(Map<String, dynamic> json) =>
    TripDetailsResponse(
      tripId: json['tripId'] as String?,
      driver: json['driver'] == null
          ? null
          : Driver.fromJson(json['driver'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      tripStatus: json['tripStatus'] as String?,
      tripDetails: json['tripDetails'] == null
          ? null
          : TripDetails.fromJson(json['tripDetails'] as Map<String, dynamic>),
      paymentDetails: json['paymentDetails'],
      polylineRoute: json['polylineRoute'] as String?,
    );

Map<String, dynamic> _$TripDetailsResponseToJson(
        TripDetailsResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'driver': instance.driver,
      'customer': instance.customer,
      'tripStatus': instance.tripStatus,
      'tripDetails': instance.tripDetails,
      'paymentDetails': instance.paymentDetails,
      'polylineRoute': instance.polylineRoute,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileUrl: json['profileUrl'] as String?,
      avgRating: (json['avgRating'] as num?)?.toInt(),
      departmentId: (json['departmentId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orgId:
          (json['orgId'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profileUrl': instance.profileUrl,
      'avgRating': instance.avgRating,
      'departmentId': instance.departmentId,
      'orgId': instance.orgId,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileUrl: json['profileUrl'],
      phoneNumber: json['phoneNumber'] as String?,
      rideCategory: json['rideCategory'] as String?,
      rideCategoryIcon: json['rideCategoryIcon'] as String?,
      makeAndModel: json['makeAndModel'] as String?,
      numberPlate: json['numberPlate'] as String?,
      fleetId: json['fleetId'],
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileUrl': instance.profileUrl,
      'phoneNumber': instance.phoneNumber,
      'rideCategory': instance.rideCategory,
      'rideCategoryIcon': instance.rideCategoryIcon,
      'makeAndModel': instance.makeAndModel,
      'numberPlate': instance.numberPlate,
      'fleetId': instance.fleetId,
      'rating': instance.rating,
    };

TripDetails _$TripDetailsFromJson(Map<String, dynamic> json) => TripDetails(
      pickupLocation: json['pickupLocation'] == null
          ? null
          : Location.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropOffLocation: json['dropOffLocation'] == null
          ? null
          : Location.fromJson(json['dropOffLocation'] as Map<String, dynamic>),
      vehicleCategory: json['vehicleCategory'],
      estimatedDistance: (json['estimatedDistance'] as num?)?.toDouble(),
      estimatedDuration: (json['estimatedDuration'] as num?)?.toInt(),
      estimatedFare: (json['estimatedFare'] as num?)?.toDouble(),
      discount: json['discount'],
      totalFare: json['totalFare'],
      status: json['status'],
      tripType: json['tripType'],
      tripDate: json['tripDate'],
      tripTime: json['tripTime'],
      dropOffTime: json['dropOffTime'],
    );

Map<String, dynamic> _$TripDetailsToJson(TripDetails instance) =>
    <String, dynamic>{
      'pickupLocation': instance.pickupLocation,
      'dropOffLocation': instance.dropOffLocation,
      'vehicleCategory': instance.vehicleCategory,
      'estimatedDistance': instance.estimatedDistance,
      'estimatedDuration': instance.estimatedDuration,
      'estimatedFare': instance.estimatedFare,
      'discount': instance.discount,
      'totalFare': instance.totalFare,
      'status': instance.status,
      'tripType': instance.tripType,
      'tripDate': instance.tripDate,
      'tripTime': instance.tripTime,
      'dropOffTime': instance.dropOffTime,
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
