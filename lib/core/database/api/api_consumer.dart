abstract class ApiConsumer {
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post({required String path,required Map<String, dynamic>? body, Map<String, dynamic>? queryParameters});
  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? body,
  });
  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? body,
  });
  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? body,
  });


}