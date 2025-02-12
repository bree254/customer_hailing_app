// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      status: json['status'],
      ratingAverage: (json['ratingAverage'] as num?)?.toInt(),
      departmentId: (json['departmentId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orgId:
          (json['orgId'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'status': instance.status,
      'ratingAverage': instance.ratingAverage,
      'departmentId': instance.departmentId,
      'orgId': instance.orgId,
    };
