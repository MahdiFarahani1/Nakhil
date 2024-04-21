import 'package:flutter_application_1/Features/Search/model/search_model.dart';
import 'package:get/get.dart';

class SearchControllerMain extends GetxController {
  late SearchModel model;

  SearchControllerMain() {
    model = SearchModel();
  }

  changeState() {
    model.changeState();
    update();
  }
}
