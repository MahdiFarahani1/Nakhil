import 'package:flutter_application_1/Features/home/model/nav_index.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  late NavModel model;

  changeState(int newIndex) {
    model.changeState(newIndex);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    model = NavModel();
  }
}
