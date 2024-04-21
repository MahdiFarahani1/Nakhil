import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';

part 'na_vcon_state.dart';

class ControllerApp extends Cubit<NaVconState> {
  ControllerApp()
      : super(NaVconState(
            status: Araghi(),
            color: ConstColor.baseColor,
            color2: ConstColor.baseColor));

  changeState() {
    if (state.status is InitFull || state.status is Nnews) {
      emit(NaVconState(
          status: Araghi(),
          color: ConstColor.baseColor,
          color2: ConstColor.baseColor));
    } else {
      emit(NaVconState(
          status: Nnews(), color: ColorNakhil.bg, color2: ColorNakhil.item));
    }
  }
}
