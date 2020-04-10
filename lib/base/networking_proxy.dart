import 'package:dio/dio.dart';

import 'config.dart';
import 'dio_networking.dart';
import 'log.dart';
import 'networking_protocol.dart';

import 'api.dart';

/// 网络代理类
/// 1. 把请求转发到具体的网络实现类
/// 2. 对数据进行加解密处理
class NetworkingProxy {
  static NetworkingProxy _instance;

  NetworkingProtocol _networkingProtocol;

  NetworkingProxy._() {
    _networkingProtocol = DioNetworking();
  }

  static NetworkingProxy get instance {
    if (_instance == null) {
      _instance = NetworkingProxy._();
    }

    return _instance;
  }

  void addInterceptor(Interceptor interceptor) {
    if (_networkingProtocol is DioNetworking) {
      (_networkingProtocol as DioNetworking).addInterceptor(interceptor);
    }
  }

  Future<T> request<T>(Api<T> api) async {
    String url = api.host;
    if (api.path != null) {
      url = url + api.path;
    }

    Map<String, String> headers = HTNetworkingConfig.instance.defaultHeaders ?? {};
    
    if (api.customHeaders != null) {
      for (var item in api.customHeaders.entries) {
        if (item.value != null) {
          headers[item.key] = item.value;
        }
      }
    }

    if (api.contentType != null) {
      headers['content-type'] = api.contentType;
    }

    if (api.method == HTHttpMethod.get) {
      return _networkingProtocol
          .get(url,
              parameters: api.parameters,
              headers: headers,
              timeout: api.timeout)
          .then((response) {
        return api.convert(response);
      });
    } else if (api.method == HTHttpMethod.post) {
      return _networkingProtocol.post(url,
              data: getPostData(api),
              parameters: api.parameters,
              headers: headers,
              timeout: api.timeout)
          .then((response) {
        return api.convert(response);
      });
    }

    footstoneLog('不支持的http method: ${api.method}');
    return null;
  }

  /// 对post数据进行加密
  dynamic getPostData(Api api) {
    if (api.requestEncodeType == RequestEncodeType.none) {
      return api.postData;
    }

    return api.postData;
  }
}

abstract class HTInterceptor {
  
}