class AuthResponse {
  int? statusCode;
  String? message;
  String? alert;
  UserResponseModel? user;

  AuthResponse({this.statusCode, this.message, this.alert, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      alert: json['alert'],
      user:
          json['user'] != null
              ? UserResponseModel.fromJson(json['user'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['alert'] = alert;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'AuthResponse(statusCode: $statusCode, message: $message, alert: $alert, user: $user)';
  }
}

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

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      imagePath: json['imagePath'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['imagePath'] = imagePath;
    data['isVerified'] = isVerified;
    return data;
  }

  @override
  String toString() {
    return 'UserResponseModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, imagePath: $imagePath, isVerified: $isVerified)';
  }
}
