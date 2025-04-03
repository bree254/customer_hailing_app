// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileUrl: json['profileUrl'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avgRating: (json['avgRating'] as num?)?.toInt(),
      departmentId: (json['departmentId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orgId:
          (json['orgId'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profileUrl': instance.profileUrl,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avgRating': instance.avgRating,
      'departmentId': instance.departmentId,
      'orgId': instance.orgId,
    };
