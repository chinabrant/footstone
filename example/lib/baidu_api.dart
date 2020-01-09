
import 'package:ht_networking/ht_networking.dart';

class BaiduApi extends BaseApi<String> {
  @override
  String get host => 'https://www.baidu.com';

  @override
  String get method => HTHttpMethod.get;

  @override
  Map<String, dynamic> get parameters => {};

  @override
  String convert(HTResponse response) {
    print(response.originalData);
    return response.originalData;
  }
}