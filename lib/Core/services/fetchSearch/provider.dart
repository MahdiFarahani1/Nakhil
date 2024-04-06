import 'package:dio/dio.dart';

class ProviderSearch {
  Future<dynamic> fetchData(
      {required String sw,
      required int sctitle,
      required int sctxt,
      required int categoryID,
      required int start}) async {
    try {
      var res = await Dio().get(
          "https://palms-news.com/api/news?start=$start&sw=$sw&sctitle=$sctitle&sctxt=$sctxt&limit=20");

      if (res.statusCode == 200) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
