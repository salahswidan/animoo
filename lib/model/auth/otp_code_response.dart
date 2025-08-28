import 'package:json_annotation/json_annotation.dart';

class OtpCodeResponse {
  final int statusCode;
  final String message;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  final UserResponseModel user;

  OtpCodeResponse({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.user,
    required this.refreshToken,
  });

  factory OtpCodeResponse.fromJson(Map<String, dynamic> json) {
    return OtpCodeResponse(
      refreshToken: json['refresh_token']?.toString() ?? '',
      statusCode:
          json['statusCode'] is int
              ? json['statusCode']
              : int.tryParse(json['statusCode'].toString()) ?? 0,
      message: json['message']?.toString() ?? '',
      accessToken: json['access_token']?.toString() ?? '',
      user: UserResponseModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode.toString(),
    "message": message.toString(),
    "access_token": accessToken.toString(),
    "refresh_token": refreshToken.toString(),
    "user": user.toJson(),
  };

  @override
  String toString() {
    return 'OtpCodeResponse{statusCode: $statusCode, message: $message, accessToken: $accessToken, refreshToken: $refreshToken, user: $user}';
  }
}

class UserResponseModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String imagePath;
  final bool isVerified;

  UserResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.imagePath,
    required this.isVerified,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id:
          json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      imagePath: json['image_path']?.toString() ?? '',
      isVerified:
          json['is_verified'] is bool
              ? json['is_verified']
              : json['is_verified'].toString().toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "image_path": imagePath,
    "is_verified": isVerified,
  };

  @override
  String toString() {
    return 'UserResponseModel{id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, imagePath: $imagePath, isVerified: $isVerified}';
  }
}
