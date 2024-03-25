import 'package:carousel_slider/carousel_slider.dart';

class SliderModel {
  CarouselController carouselController = CarouselController();
  final int _index = 0;

  int get index => _index;

  nextPage() {
    carouselController.nextPage();
  }

  previousPage() {
    carouselController.previousPage();
  }
}
