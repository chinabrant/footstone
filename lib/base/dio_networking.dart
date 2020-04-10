/*
 * @Author: Brant
 * @Date: 2019-12-25 08:44:06
 * @LastEditors: Brant
 * @LastEditTime: 2019-12-26 15:32:25
 * @Description: 
 */

import 'package:dio/dio.dart';
import 'response.dart' as footstone;
import 'log.dart';
import 'networking_protocol.dart';

class DioNetworking extends NetworkingProtocol {
  final Dio _dio = Dio();

  // static BaseOptions get _baseOptions {
  //   BaseOptions options = new BaseOptions();
  //   options.headers = HTNetworkingConfig.instance.defaultHeaders;
  //   options.connectTimeout = HTNetworkingConfig.instance.connectTimeout;
  //   options.receiveTimeout = HTNetworkingConfig.instance.receiveTimeout;
  //   options.baseUrl = HTNetworkingConfig.instance.baseUrl;
  //   return options;
  // }

  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  Future<footstone.Response> get(String url,
      {Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10}) async {
    footstoneLog('get request: $url, parameters: $parameters, headers: $headers');

    try {
      var response = await _dio.get(url,
          queryParameters: parameters,
          options: Options(
              receiveTimeout: timeout * 1000,
              sendTimeout: timeout * 1000,
              headers: headers));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return footstone.Response(
            isSuccess: true,
            originalData: response.data,
            statusCode: response.statusCode);
      } else {
        return footstone.Response(
            isSuccess: false,
            originalData: response.data,
            statusCode: response.statusCode,
            errorMsg: response.statusMessage);
      }
    } on DioError catch (e) {
      footstoneLog('DioError: $e');
      return footstone.Response(
          isSuccess: false, originalData: null, errorMsg: e.toString());
    }
    // return null;
  }

  Future<footstone.Response> post(String url,
      {dynamic data,
      Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10}) async {
    footstoneLog('post request: $url, parameters: $parameters, headers: $headers');
    try {
      var response = await _dio.post(url,
          data: data,
          // queryParameters: parameters,
          options: Options(receiveTimeout: timeout * 1000, headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return footstone.Response(
            isSuccess: true,
            originalData: response.data,
            statusCode: response.statusCode);
      } else {
        return footstone.Response(
            isSuccess: false,
            originalData: response.data,
            statusCode: response.statusCode,
            errorMsg: response.statusMessage);
      }
    } on DioError catch (e) {
      footstoneLog('DioError: $e');
      return footstone.Response(
          isSuccess: false, originalData: null, errorMsg: e.toString());
    }
  }
}
