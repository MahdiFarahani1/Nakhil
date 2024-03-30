import 'package:get/get.dart';
import 'package:nakhil/Core/services/fetchContentApi/model/content_model.dart';
import 'package:nakhil/Core/services/provider_all.dart';

class ServiceClickController extends GetxController {
  dynamic data;
  late StatusClickNews status;

  fetchData({required int id}) async {
    try {
      status = ClickLoading();
      update();

      var response = await ProviderAll().fetchClickData(id: id);
      print("mehdi mehdi mehdi mehdi mehdi mehdi mheid");
      if (response.statusCode == 200) {
        print(response.statusCode);
        var newsModel = ContentModel.fromJson(response.data);
        data = null;
        data = newsModel;
        status = ClickComplete();
        update();
      } else {
        status = ClickError();
        update();
      }
    } catch (e) {
      print(e);
      status = ClickError();
      update();
    }
  }
}

abstract class StatusClickNews {}

class ClickLoading extends StatusClickNews {}

class ClickError extends StatusClickNews {}

class ClickComplete extends StatusClickNews {}
