import 'package:animoo/model/auth/auth_response.dart';
import 'package:json_annotation/json_annotation.dart';

class NewOtpCodeResponse {
  @JsonKey(name: 'statusCode')
  final int statusCode;
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'alert')
  final String alert;

  @JsonKey(name: 'user')
  final UserResponseModel user;

  NewOtpCodeResponse({
    required this.statusCode,
    required this.message,
    required this.alert,
    required this.user,
  });

  factory NewOtpCodeResponse.fromJson(Map<String, dynamic> json) {
    return NewOtpCodeResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      alert: json['alert'],
      user: UserResponseModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'alert': alert,
      'user': user.toJson(),
    };
  }


}
