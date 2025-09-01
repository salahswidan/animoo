class ApiConstants {
  ApiConstants._();

  //  static const String baseUrl = 'http://192.168.1.100:8000';
  //baseUrl = 'http://10.0.2.2:8000/api/';

  static const String baseUrl = 'http://10.0.2.2:8000';
  static const String signUpEndpoint = '/api/signup';
  static const String otpCheckEndpoint = '/api/verfication_code';
  static const String loginEndpoint = '/api/login';
  static const String createNewPasswordEndpoint = '/api/create_new_possword';
  static const String resendNewOtpCodeEndpoint =
      '/api/create_new_verfication_code';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String image = 'image';

  static const String code = 'code';

  static const String confirmPassword = 'confirmPassword';
}
