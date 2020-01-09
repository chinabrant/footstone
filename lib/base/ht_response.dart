/*
 * @Author: Brant
 * @Date: 2019-11-07 15:49:40
 * @LastEditors  : Brant
 * @LastEditTime : 2019-12-26 15:32:21
 * @Description: 
 */

/// 网络请求结果
class HTResponse<K> {
  final K object;
  final bool isSuccess;
  final int statusCode;
  final String errorMsg;
  // final Error error;
  final dynamic originalData;

  HTResponse({this.object, this.isSuccess, this.statusCode, this.errorMsg, this.originalData});

  /// 接口正常返回后的status
  int get status {
    if (originalData != null && originalData['status'] is int) {
      return originalData['status'];
    }

    return -1;
  }

  dynamic get data {
    if (originalData == null) {
      return null;
    }
    
    return originalData['data'];
  }

  String get msg {
    if (originalData == null) {
      return null;
    }

    return originalData['msg'];
  }
}