import 'package:get/get.dart';
import 'package:nakhil/Features/Search/model/search_model.dart';

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
