import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/services/provider_all.dart';
part 'slider_p_state.dart';

class SliderPCubit extends Cubit<SliderPState> {
  SliderPCubit() : super(SliderPState(status: LoadingSlider()));

  fetchArtSlider(BuildContext context) async {
    emit(SliderPState(status: LoadingSlider()));
    var res = await ProviderAll().fetchArtData(context: context, start: 0);
    if (res.statusCode == 200) {
      var data = res.data["sliders"];

      Map item1 = {
        "title": data[0]["title"],
        "id": data[0]["id"],
        "img": data[0]["img"],
      };
      Map item2 = {
        "title": data[1]["title"],
        "id": data[1]["id"],
        "img": data[1]["img"],
      };
      Map item3 = {
        "title": data[2]["title"],
        "id": data[2]["id"],
        "img": data[2]["img"],
      };
      Map item4 = {
        "title": data[3]["title"],
        "id": data[3]["id"],
        "img": data[3]["img"],
      };

      print(item1.values);
      emit(SliderPState(
        sliderData: [
          item1,
          item2,
          item3,
          item4,
        ],
        status: CompleteSlider(),
      ));
    }
  }
}

abstract class SliderStatus {}

class LoadingSlider extends SliderStatus {}

class ErrorSlider extends SliderStatus {}

class CompleteSlider extends SliderStatus {}
