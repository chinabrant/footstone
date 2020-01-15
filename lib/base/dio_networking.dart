/*
 * @Author: Brant
 * @Date: 2019-12-25 08:44:06
 * @LastEditors: Brant
 * @LastEditTime: 2019-12-26 15:32:25
 * @Description: 
 */

import 'package:dio/dio.dart';
import 'package:ht_networking/base/log.dart';
import 'package:ht_networking/base/networking_protocol.dart';
import 'api.dart';
import 'config.dart';
import 'ht_response.dart';

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

  Future<HTResponse> get(String url,
      {Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10}) async {
    htNetworkingLog('get request: $url, parameters:$parameters');

    try {
      var response = await _dio.get(url,
          queryParameters: parameters,
          options: Options(
              receiveTimeout: timeout * 1000,
              sendTimeout: timeout * 1000,
              headers: headers));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HTResponse(
            isSuccess: true,
            originalData: response.data,
            statusCode: response.statusCode);
      } else {
        return HTResponse(
            isSuccess: false,
            originalData: response.data,
            statusCode: response.statusCode,
            errorMsg: response.statusMessage);
      }
    } on DioError catch (e) {
      htNetworkingLog('DioError: $e');
      return HTResponse(
          isSuccess: false, originalData: null, errorMsg: e.toString());
    }
    // return null;
  }

  Future<HTResponse> post(String url,
      {dynamic data,
      Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10}) async {
    htNetworkingLog('post request: $url');
    try {
      var response = await _dio.post(url,
          data: data,
          // queryParameters: parameters,
          options: Options(receiveTimeout: timeout * 1000, headers: headers));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HTResponse(
            isSuccess: true,
            originalData: response.data,
            statusCode: response.statusCode);
      } else {
        return HTResponse(
            isSuccess: false,
            originalData: response.data,
            statusCode: response.statusCode,
            errorMsg: response.statusMessage);
      }
    } on DioError catch (e) {
      htNetworkingLog('DioError: $e');
      return HTResponse(
          isSuccess: false, originalData: null, errorMsg: e.toString());
    }
  }
}
