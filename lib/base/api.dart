/*
 * @Author: Brant
 * @Date: 2019-12-25 08:44:06
 * @LastEditors  : Brant
 * @LastEditTime : 2019-12-26 15:32:12
 * @Description: 
 */

import 'package:ht_networking/base/ht_response.dart';

import 'dio_networking.dart';

// 请求数据的加密类型
enum RequestEncodeType { none, json, aes128, xxtea }

enum ResponseDecodeType { none, json, aes128, xxtea }

class HTHttpMethod {
  static final String get = 'get';
  static final String post = 'post';
}

/// 接口的基类，泛型T为convert方法的返回值
/// 网络返回后会掉用convert方法来解析数据，所以子类要实现convert方法把数据解析到对象或其他
abstract class Api<T> {
  /// 请求的host
  String host;

  /// 请求地址的path
  String path;

  /// get post
  String method;

  /// 自定义的请求头
  Map<String, dynamic> customHeaders;

  /// 请求头的content-type, 会根据content-type对数据进行加密
  String contentType;

  /// 请求参数
  Map<String, dynamic> parameters;

  /// post的数据，如果是post请求，优先读取这个字段
  dynamic postData;

  /// 超时时间
  int timeout;

  /// 请求数据的加密类型
  RequestEncodeType requestEncodeType;

  /// 响应数据的解密类型
  ResponseDecodeType responseDecodeType;

  /// 子类重载这个方法，将数据解析好
  T convert(HTResponse response) {
    return null;
  }

  /// TODO:
  /// 1. 根据content-type对数据进行加密
  /// 2. 公共请求头的设置
  Future<T> start() async {
    String url = host;
    if (path != null) {
      url = url + path;
    }

    Map<String, dynamic> headers = customHeaders ?? {};
    if (contentType != null) {
      headers['content-type'] = contentType;
    }

    if (method == HTHttpMethod.get) {
      return DioNetworking.get(url,
              parameters: parameters, headers: headers, timeout: timeout)
          .then((response) {
        return convert(response);
      });
    } else if (method == HTHttpMethod.post) {
      return DioNetworking.post(host + path,
              data: getPostData(),
              parameters: parameters,
              headers: headers,
              timeout: timeout)
          .then((response) {
        return convert(response);
      });
    }

    return null;
  }

  /// 对post数据进行加密
  dynamic getPostData() {
    if (requestEncodeType == RequestEncodeType.none) {
      return postData;
    }

    return postData;
  }
}
