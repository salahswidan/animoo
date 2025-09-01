import 'package:animoo/model/auth/auth_response.dart';

class CreateNewPasswordResponse {
  final int statusCode;
  final String message;
  final String access_token;
  final String refresh_token;
  final UserResponseModel user;

  CreateNewPasswordResponse({
    required this.statusCode,
    required this.message,
    required this.access_token,
    required this.refresh_token,
    required this.user,
  });

  factory CreateNewPasswordResponse.fromJson(Map<String, dynamic> json) {
    return CreateNewPasswordResponse(
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

  @override
  String toString() {
    return 'CreateNewPasswordResponse{statusCode: $statusCode, message: $message, access_token: $access_token, refresh_token: $refresh_token, user: $user}';
  }
}
