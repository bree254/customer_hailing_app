import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "profileUrl")
  String? profileUrl;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "avgRating")
  int? avgRating;
  @JsonKey(name: "departmentId")
  List<String>? departmentId;
  @JsonKey(name: "orgId")
  List<String>? orgId;

  UserResponse({
    this.id,
    this.email,
    this.phoneNumber,
    this.profileUrl,
    this.firstName,
    this.lastName,
    this.avgRating,
    this.departmentId,
    this.orgId,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}


