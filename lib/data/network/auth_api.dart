import 'package:animoo/core/error/failure_model.dart';
import 'package:animoo/model/auth/auth_response.dart';
import 'package:animoo/model/auth/new_otp_code_response.dart';
import 'package:animoo/model/auth/otp_code_response.dart';
import 'package:animoo/model/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/database/api/api_constants.dart';
import '../../core/database/api/dio_service.dart';
import '../../core/di/services/get_it.dart';
import '../../core/error/server_exception.dart';

class AuthApi {
  AuthApi._();

  static Future<Either<FailureModel, AuthResponse>> signUp(
    UserModel user,
  ) async {
    try {
      DioService dioService = getIt<DioService>();

      var response = await dioService.post(
        path: ApiConstants.signUpEndpoint,
        body: FormData.fromMap({
          ApiConstants.firstName: user.firstName,
          ApiConstants.lastName: user.lastName,
          ApiConstants.email: user.email,
          ApiConstants.password: user.password,
          ApiConstants.phone: user.phone,
          ApiConstants.image: await MultipartFile.fromFile(
            user.image.path,
            filename: user.image.path.split("/").last,
          ),
          // TODO add body
        }),
      );

      print(response.toString());
      return Right(AuthResponse.fromJson(response));
    } on ServerException catch (e) {
      return left(handleServerExceptionError(e));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          'errors': [e.toString()],
          'statusCode': '500',
        }),
      );
    }
  }

  static Future<Either<FailureModel, OtpCodeResponse>> checkOtpAvailability(
    String email,
    String code,
  ) async {
    try {
      DioService dioService = getIt<DioService>();

      var response = await dioService.post(
        path: ApiConstants.otpCheckEndpoint,
        body: {ApiConstants.email: email, ApiConstants.code: code},
      );

      return Right(OtpCodeResponse.fromJson(response));
    } on ServerException catch (e) {
      return left(handleServerExceptionError(e));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          'errors': [e.toString()],
          'statusCode': '500',
        }),
      );
    }
  }
  static Future<Either<FailureModel, NewOtpCodeResponse>> resendOtpCode(
    String email,
  ) async {
    try {
      DioService dioService = getIt<DioService>();

      var response = await dioService.post(
        path: ApiConstants.resendNewOtpCodeEndpoint,
        body: {ApiConstants.email: email},
      );

      return Right(NewOtpCodeResponse.fromJson(response));
    } on ServerException catch (e) {
      return left(handleServerExceptionError(e));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          'errors': [e.toString()],
          'statusCode': '500',
        }),
      );
    }
  }

  static FailureModel handleServerExceptionError(
    ServerException e,
  ) {
    Map<String, dynamic> errors;
    if (e.data['error'] == null) {
      errors = {
        "error": [e.data['message'].toString()],
        "statusCode": 504,
      };
    } else {
      errors = e.data;
    }
    return FailureModel.fromJson(errors);
  }
}
