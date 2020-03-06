import 'package:ht_networking/ht_networking.dart';

abstract class NetworkingProtocol {
  /// send get request
  Future<HTResponse> get(String url,
      {Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10});

  /// send post request
  Future<HTResponse> post(String url,
      {dynamic data,
      Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10});

  /// 专为protocol-buffers格式打造的请求方式
  /// responseType: ResponseType.bytes
  Future<HTResponse> pb(String url,
      {dynamic data,
        Map<String, dynamic> parameters,
        Map<String, String> headers,
        int timeout = 10});
}
