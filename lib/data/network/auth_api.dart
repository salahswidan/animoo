import 'dart:io';

import 'package:animoo/core/error/failure_model.dart';
import 'package:animoo/model/auth/auth_response.dart';
import 'package:animoo/model/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/database/api/api_constants.dart';
import '../../core/database/api/dio_service.dart';
import '../../core/error/server_exception.dart';

class AuthApi {
  AuthApi._();

  static Future<Either<FailureModel, AuthResponse>> signUp(
    UserModel user,
  ) async {
    try {
      DioService dioService = DioService(Dio()); //TODO? don't forget to inject

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
      print(e.data.toString() + " server exception");
      return Left(FailureModel.fromJson(e.data));
    } catch (e) {
      print(e.toString() + " normal catch");
      return Left(
        FailureModel.fromJson({
          'errors': [e.toString()],
          'statusCode': '500',
        }),
      );
    }
  }
}
