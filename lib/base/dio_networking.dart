/*
 * @Author: Brant
 * @Date: 2019-12-25 08:44:06
 * @LastEditors: Brant
 * @LastEditTime: 2019-12-26 15:32:25
 * @Description: 
 */
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:ht_networking/base/config.dart';
import 'package:ht_networking/base/ht_response.dart';

class DioNetworking {
  static Dio dio = Dio(_baseOptions);

  static BaseOptions get _baseOptions {
    BaseOptions options = new BaseOptions();
    options.headers = HTNetworkingConfig.instance.defaultHeaders;
    options.connectTimeout = HTNetworkingConfig.instance.connectTimeout;
    options.receiveTimeout = HTNetworkingConfig.instance.receiveTimeout;
    options.baseUrl = HTNetworkingConfig.instance.baseUrl;
    return options;
  }

  static Future get(String url,
      {Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10}) async {
    try {
      var response = await dio.get(url,
          queryParameters: parameters,
          options: Options(receiveTimeout: timeout * 1000, headers: headers));

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
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
      print('DioNetworking: [$url], ${e.toString()}');
      return HTResponse(isSuccess: false, originalData: null, errorMsg: e.toString());
    }
  }

  static Future post(String url,
      {dynamic data,
      Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10}) async {
    // print('parameters: $parameters');
    try {
      var response = await dio.post(url,
          data: data,
          // queryParameters: parameters,
          options: Options(receiveTimeout: timeout * 1000, headers: headers));

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
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
      print('DioNetworking: [$url], ${e.toString()}');
      return HTResponse(isSuccess: false, originalData: null, errorMsg: e.toString());
    }
  }
}
