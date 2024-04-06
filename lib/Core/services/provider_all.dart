import 'package:dio/dio.dart';

class ProviderAll {
  Future<Response<dynamic>> fetchAllData({required int start}) async {
    var res = await Dio()
        .get("https://palms-news.com/api/news?start=$start&limit=20");
    return res;
  }

  Future<Response<dynamic>> fetchClickData({
    required int id,
  }) async {
    var res =
        await Dio().post("https://palms-news.com/api/news/content?&id=$id");
    return res;
  }
}
