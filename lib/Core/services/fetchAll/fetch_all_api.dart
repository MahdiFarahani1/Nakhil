import 'package:get/get.dart';
import 'package:nakhil/Core/services/fetchAll/models/title_news_model.dart';
import 'package:nakhil/Core/services/fetchAll/provider_all.dart';

class ServiceController extends GetxController {
  List<TitleNewsModel>? data;
  var status = Rx<StatusTitleNews>(Loading());
  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  fetchData() async {
    var response = await ProviderAll().fetchData(start: 0, limit: 20);
    if (response.statusCode == 200) {
      List<dynamic> newsList = response.data['posts'];
      List<TitleNewsModel> newsModel =
          newsList.map((json) => TitleNewsModel.fromJson(json)).toList();
      //  data?.clear();
      //  data = [...newsModel];
      status.value = Complete();
      update();
    }
  }
}

abstract class StatusTitleNews {}

class Loading extends StatusTitleNews {}

class Error extends StatusTitleNews {}

class Complete extends StatusTitleNews {}
