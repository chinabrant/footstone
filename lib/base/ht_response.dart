/*
 * @Author: Brant
 * @Date: 2019-11-07 15:49:40
 * @LastEditors  : Brant
 * @LastEditTime : 2019-12-26 15:32:21
 * @Description: 
 */

import 'dart:convert';

/// 网络请求结果
class HTResponse<K> {
  final K object;
  final bool isSuccess;
  final int statusCode;
  final String errorMsg;
  // final Error error;
  final dynamic originalData;
  Map<String, dynamic> decodeData;

  HTResponse({this.object, this.isSuccess, this.statusCode, this.errorMsg, this.originalData}) {
    decodeData = _decodeData;
  }

  /// 接口正常返回后的status
  int get status {
    if (decodeData != null && decodeData['status'] is int) {
      return decodeData['status'];
    }

    return -1;
  }

  dynamic get data {
    if (decodeData == null) {
      return null;
    }
    
    return decodeData['data'];
  }

  String get msg {
    if (decodeData == null) {
      return null;
    }

    return decodeData['msg'];
  }

  Map<String, dynamic> get _decodeData {
    if (originalData is String) {
      return json.decode(originalData);
    }

    return originalData;
  }
}