

import 'response.dart';

abstract class NetworkingProtocol {
  /// send get request
  Future<Response> get(String url,
      {Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10});

  /// send post request
  Future<Response> post(String url,
      {dynamic data,
      Map<String, dynamic> parameters,
      Map<String, String> headers,
      int timeout = 10});
}
