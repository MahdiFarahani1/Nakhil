import 'package:get/get.dart';
import 'package:nakhil/Core/services/fetchAll/model/title_news_model.dart';
import 'package:nakhil/Core/services/provider_all.dart';

class ServiceController extends GetxController {
  dynamic data;
  late StatusTitleNews status;
  int loadMoreCount = 0;

  fetchData({required int start, required int limit}) async {
    try {
      status = Loading();
      update();

      var response =
          await ProviderAll().fetchAllData(start: start, limit: limit);

      if (response.statusCode == 200) {
        var newsModel = TitleNewsModel.fromJson(response.data);

        data = null;
        data = newsModel;
        status = Complete();
        update();
      } else {
        status = Error();
        update();
      }
    } catch (e) {
      status = Error();
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData(start: 0, limit: 20);
  }
}

abstract class StatusTitleNews {}

class Loading extends StatusTitleNews {}

class Error extends StatusTitleNews {}

class Complete extends StatusTitleNews {}
