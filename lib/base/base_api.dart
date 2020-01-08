/*
 * @Author: Brant
 * @Date: 2019-10-22 09:38:40
 * @LastEditors  : Brant
 * @LastEditTime : 2019-12-26 15:32:05
 * @Description: 
 */

import 'package:ht_networking/base/config.dart';

import 'api.dart';

/// 接口基类，实现默认参数
class BaseApi<T> extends Api<T> {

  @override
  String contentType = 'application/json';

  @override
  Map<String, dynamic> customHeaders;

  @override
  String host = HTNetworkingConfig.instance.baseUrl;

  @override
  String method = "get";

  @override
  int timeout = 10;

}