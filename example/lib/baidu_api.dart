
import 'package:ht_networking/base/api.dart';
import 'package:ht_networking/base/base_api.dart';
import 'package:ht_networking/footstone.dart';

class BaiduApi extends BaseApi<String> {
  @override
  String get host => 'https://www.baidu.com';

  @override
  String get method => HTHttpMethod.get;

  @override
  Map<String, dynamic> get parameters => {};

  @override
  String convert(Response response) {
    print(response.originalData);
    return response.originalData;
  }
}