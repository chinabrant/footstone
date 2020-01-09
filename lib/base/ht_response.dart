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
}