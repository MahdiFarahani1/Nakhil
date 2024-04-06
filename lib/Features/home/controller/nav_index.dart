import 'package:get/get.dart';
import 'package:nakhil/Features/home/model/nav_index.dart';

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
