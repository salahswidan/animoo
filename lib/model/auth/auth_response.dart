import 'package:json_annotation/json_annotation.dart';
part 'auth_response.g.dart';

@JsonSerializable()

class AuthResponse {
  String? statusCode;
  String? message;
  String? alert;
  UserResponseModel? user;

  AuthResponse({this.statusCode, this.message, this.alert, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  String toString() {
    return 'AuthResponse(statusCode: $statusCode, message: $message, alert: $alert, user: $user)';
  }
}
@JsonSerializable()
class UserResponseModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? imagePath;
  String? isVerified;

  UserResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.imagePath,
    this.isVerified,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);


  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);


  @override
  String toString() {
    return 'UserResponseModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, imagePath: $imagePath, isVerified: $isVerified)';
  }
}
