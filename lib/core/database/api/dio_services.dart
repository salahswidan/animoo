import 'package:animoo/core/database/api/api_constants.dart';
import 'package:animoo/core/error/server_exception.dart';
import 'package:dio/dio.dart';

import 'api_consumer.dart';

class DioServices extends ApiConsumer {
  Dio dio;

  DioServices(this.dio) {
    dio.options.baseUrl = ApiConstants.baseUrl;
  }

  @override
  Future delete({required String path, Map<String, dynamic>? body}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get({required String path, Map<String, dynamic>? queryParameters}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future patch({required String path, Map<String, dynamic>? body}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future post({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Object body,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //?success
        return response.data;
      } else {
        //?failure
        throw ServerException(
          data: response.data as Map<String, dynamic>,
          statusCode: response.statusCode!,
          message: '',
        );
      }
    } catch (e) {
      //?exception
      await handleDioException(e);
    }
  }

  Future<void> handleDioException(Object e) async {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: e.response!.statusMessage ?? 'Connection timed out',
          );
        case DioExceptionType.sendTimeout:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response?.statusCode ?? 408,
            message: e.response?.statusMessage ?? 'send timed out',
          );
        case DioExceptionType.receiveTimeout:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response?.statusCode ?? 408,
            message: e.response?.statusMessage ?? 'Response timed out',
          );
        case DioExceptionType.badResponse:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode!,
            message: e.response!.statusMessage ?? 'Bad response',
          );
        case DioExceptionType.cancel:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response?.statusCode ?? 408,
            message: e.response?.statusMessage ?? 'Request cancelled',
          );
        case DioExceptionType.badCertificate:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response?.statusCode ?? 495,
            message: e.response?.statusMessage ?? 'Bad certificate',
          );
        case DioExceptionType.connectionError:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response?.statusCode ?? 408,
            message: e.response?.statusMessage ?? 'Connection error',
          );
        case DioExceptionType.unknown:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response?.statusCode ?? 500,
            message: e.response?.statusMessage ?? 'Unknown error',
          );
      }
    }
  }

  @override
  Future put({required String path, Map<String, dynamic>? body}) async {
    final response = await dio.put(path, data: body);
    return response.data;
  }
}
