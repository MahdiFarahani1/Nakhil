import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
            fontsizeContent: 12,
            fontsizeTitle: 16,
            titleColor: Colors.black.value));
  changeTitle(double value) {
    emit(state.copyWith(fontsizeTitle: value.toInt()));
  }

  changeContent(double value) {
    emit(state.copyWith(fontsizeContent: value.toInt()));
  }

  changeTitleColor(int color) {
    emit(state.copyWith(titleColor: color));
  }
}
