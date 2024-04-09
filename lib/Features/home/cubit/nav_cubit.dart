import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit() : super(NavState(index: 0));

  nextPage(CarouselController carouselController) {
    carouselController.nextPage();
  }

  previousPage(CarouselController carouselController) {
    carouselController.previousPage();
  }
}
