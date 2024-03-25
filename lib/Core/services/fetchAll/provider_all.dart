import 'package:dio/dio.dart';

class ProviderAll {
  Future<Response<dynamic>> fetchData(
      {required int start, required int limit}) async {
    var res = await Dio()
        .get("https://palms-news.com/api/news?start=$start&limit=$limit");
    return res;
  }
}
