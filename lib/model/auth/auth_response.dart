// import 'package:json_annotation/json_annotation.dart';
// part 'auth_response.g.dart';

// @JsonSerializable()

// class AuthResponse {
//   String? statusCode;
//   String? message;
//   String? alert;
//   UserResponseModel? user;

//   AuthResponse({this.statusCode, this.message, this.alert, this.user});

//   factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

//   @override
//   String toString() {
//     return 'AuthResponse(statusCode: $statusCode, message: $message, alert: $alert, user: $user)';
//   }
// }
// @JsonSerializable()
// class UserResponseModel {
//   String? id;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phone;
//   String? imagePath;
//   String? isVerified;

//   UserResponseModel({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.imagePath,
//     this.isVerified,
//   });

//   factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);


//   Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);


//   @override
//   String toString() {
//     return 'UserResponseModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, imagePath: $imagePath, isVerified: $isVerified)';
//   }
// }
class AuthResponse {
  final int statusCode;
  final String message;
  final String alert;
  final UserResponseModel user;

  AuthResponse({
    required this.statusCode,
    required this.message,
    required this.alert,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      statusCode: json['statusCode'] is int
          ? json['statusCode']
          : int.tryParse(json['statusCode'].toString()) ?? 0,
      message: json['message']?.toString() ?? '',
      alert: json['alert']?.toString() ?? '',
      user: UserResponseModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "alert": alert,
        "user": user.toJson(),
      };
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
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      imagePath: json['image_path']?.toString() ?? '',
      isVerified: json['is_verified'] is bool
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
}
