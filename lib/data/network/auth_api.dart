import 'dart:io';

import 'package:animoo/core/database/api/dio_services.dart';

import 'package:dio/dio.dart';

import '../../core/database/api/api_constants.dart';
import '../../core/error/server_exception.dart';

class AuthApi {
  AuthApi._();

  static Future signUp(File image) async {
    try {
      DioServices dioService = DioServices(
        Dio(),
      ); //TODO? don't forget to inject
      var response = await dioService.post(
        path: ApiConstants.signUpEndPoint,
        body: FormData.fromMap({
          "firstName": 'ahmed',
          "lastName": 'ahmed',
          "email": 'ahmed122727727@gmail.com',
          "password": '12345678A!@aw2',
          "phone": '01001398831',
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.path.split("/").last,
          ),
          // TODO add body
        }),
      );
      // TODO: handle response good
      print(response);
    } on ServerException catch (e) {
      // TODO: handle response bad
      print(e.message);
      print(e.statusCode);
      print(e.data);
    } catch (e) {
      // TODO: handle exception

      print(e.toString());
      print("normal exception");
    }
  }
}
