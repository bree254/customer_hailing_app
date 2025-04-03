import 'package:json_annotation/json_annotation.dart';

part 'upload_file.g.dart';
@JsonSerializable()
class UploadFileResponse {
  @JsonKey(name: "url")
  String? url;

  UploadFileResponse({
    this.url,
  });

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) => _$UploadFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFileResponseToJson(this);
}
