import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "status")
  dynamic status;
  @JsonKey(name: "ratingAverage")
  int? ratingAverage;
  @JsonKey(name: "departmentId")
  List<String>? departmentId;
  @JsonKey(name: "orgId")
  List<String>? orgId;

  UserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.status,
    this.ratingAverage,
    this.departmentId,
    this.orgId,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}



