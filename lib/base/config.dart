import 'dart:io';

class HTEnvType {
  static final String dev = 'development';
  static final String production = 'production';
}

/// 给各个app进行设置
class HTNetworkingConfig {
  static HTNetworkingConfig _instance;
  HTNetworkingConfig._();

  static HTNetworkingConfig get instance {
    if (_instance == null) {
      _instance = HTNetworkingConfig._();
    }

    return _instance;
  }

  String env = HTEnvType.production;
  String baseUrl;
  int connectTimeout; /// 毫秒
  int receiveTimeout; /// 毫秒

  /// 默认的全局请求头
  Map<String, String> defaultHeaders = {
    "version": '',
    "OS": _platform,
    "user-agent": "flutter",
  };

  static String get _platform {
    if (Platform.isIOS) {
      return 'IOS';
    } else if (Platform.isAndroid) {
      return 'Android';
    }

    return 'unknow';
  }
}