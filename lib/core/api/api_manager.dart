import 'package:boilerlib/core/api/api_interceptors.dart';
import 'package:dio/dio.dart';

class ApiManager {
  String? baseurl;
  bool? isFormData;
  String? keySession;
  Map<String, dynamic> headerApi = {};

  static final ApiManager apiServices = ApiManager._internal();

  factory ApiManager(
      {required String urlBase,
      required bool formData,
      required String key,
      required Map<String, dynamic> header}) {
    apiServices.baseurl = urlBase;
    apiServices.isFormData = formData;
    apiServices.headerApi = header;
    apiServices.keySession = key;
    return apiServices;
  }

  ApiManager._internal();

  Dio apiManager() {
    var option = BaseOptions(
        baseUrl: baseurl!,
        headers: headerApi,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 100));
    return Dio(option)..interceptors.add(ApiInterceptor(keySession!));
  }
}
