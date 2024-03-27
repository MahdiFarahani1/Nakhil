import 'package:get/get.dart';
import 'package:nakhil/Core/services/fetchAll/models/title_news_model.dart';
import 'package:nakhil/Core/services/fetchAll/provider_all.dart';

class ServiceController extends GetxController {
  dynamic data;
  late StatusTitleNews status;

  fetchData() async {
    try {
      status = Loading();
      update();

      var response = await ProviderAll().fetchData(start: 0, limit: 20);

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
    fetchData();
    super.onInit();
  }
}

abstract class StatusTitleNews {}

class Loading extends StatusTitleNews {}

class Error extends StatusTitleNews {}

class Complete extends StatusTitleNews {}
