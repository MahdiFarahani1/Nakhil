import 'package:get/get.dart';
import 'package:nakhil/Core/services/fetchAll/models/title_news_model.dart';
import 'package:nakhil/Core/services/fetchAll/provider_all.dart';

class ServiceController extends GetxController {
  dynamic data;
  late StatusTitleNews status;

  fetchData() async {
    status = Loading();
    update();

    // دریافت داده از سرور
    var response = await ProviderAll().fetchData(start: 0, limit: 20);

    if (response.statusCode == 200) {
      // تبدیل داده JSON به مدل‌های Dart
      var newsModel = TitleNewsModel.fromJson(response.data);

      // به‌روزرسانی داده و وضعیت برنامه

      data = null;
      data = newsModel;
      status = Complete();
      update();

      // چاپ مدل اولیه پست‌ها به کنسول
      print(newsModel.posts?.first.title);
    } else {
      // در صورتی که پاسخ از سرور با مشکل مواجه شود
      status = Error();
      update();
    }
  }
}

abstract class StatusTitleNews {}

class Loading extends StatusTitleNews {}

class Error extends StatusTitleNews {}

class Complete extends StatusTitleNews {}
