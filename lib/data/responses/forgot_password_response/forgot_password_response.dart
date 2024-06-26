// {
//     "status": 200,
//     "message": "You change your password",
//     "password": "123456"
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "password")
  final String? password;

  const ForgotPasswordResponse({
    this.status,
    this.message,
    this.password,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}