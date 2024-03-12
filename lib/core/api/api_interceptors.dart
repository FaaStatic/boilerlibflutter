import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  String keySession;
  ApiInterceptor(this.keySession);


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
