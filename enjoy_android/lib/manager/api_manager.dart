import 'package:dio/dio.dart';
import 'package:enjoy_android/model/wechat_count_bean.dart';

class ApiManager {
  Dio _dio;

  factory ApiManager() => _getInstance();
  static ApiManager _instance;

  ApiManager._internal() {
    var options = BaseOptions(
        baseUrl: "http://www.wanandroid.com/",
        connectTimeout: 10000,
        receiveTimeout: 3000);
    _dio = Dio(options);
  }

  static ApiManager _getInstance() {
    if (_instance == null) {
      _instance = new ApiManager._internal();
    }
    return _instance;
  }

  static ApiManager get instance => _getInstance();

  /// 获取推荐微信公众号
  Future<List<WechatCount>> getWechatCount() async {
    try {
      Response response = await _dio.get("wxarticle/chapters/json");
      return WechatCountBean.fromJson(response.data).data;
    } catch (e) {
      return null;
    }
  }
}
