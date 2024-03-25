import 'package:get/get.dart';
import 'package:nakhil/Features/home/model/slider_images.dart';

class SliderController extends GetxController {
  late SliderModel model;

  SliderController() {
    model = SliderModel();
  }

  nextPage() {
    model.nextPage();
    update();
  }

  previousPage() {
    model.previousPage();
    update();
  }
}
