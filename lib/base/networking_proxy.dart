import 'package:ht_networking/base/dio_networking.dart';
import 'package:ht_networking/base/log.dart';
import 'package:ht_networking/base/networking_protocol.dart';
import 'package:ht_networking/ht_networking.dart';

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

  Future request(Api api) {
    String url = api.host;
    if (api.path != null) {
      url = url + api.path;
    }

    Map<String, String> headers = api.customHeaders ?? {};
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

    htNetworkingLog('不支持的http method: ${api.method}');
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
