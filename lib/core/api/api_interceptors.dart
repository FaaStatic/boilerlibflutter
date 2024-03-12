import 'package:boilerlib/boilerlib.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  String keySession;
  ApiInterceptor(this.keySession);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (keySession.isNotEmpty) {
      var result = await StorageUtil().getAsMap(keySession);
      options.headers.addAll({"token": result?["token"]});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
