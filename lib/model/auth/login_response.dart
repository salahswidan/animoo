import 'package:animoo/model/auth/auth_response.dart';

class LoginResponse {
  final int statusCode;
  final String message;
  final String access_token;
  final String refresh_token;
  final UserResponseModel user;

  LoginResponse({
    required this.statusCode,
    required this.message,
    required this.access_token,
    required this.user,
    required this.refresh_token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
      user: UserResponseModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'access_token': access_token,
      'refresh_token': refresh_token,
      'user': user.toJson(),
    };
  }
}