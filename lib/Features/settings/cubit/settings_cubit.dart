import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/gen/fonts.gen.dart';
import 'package:flutter_application_1/main.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
            fontsizeContent: 14,
            fontsizeTitle: 17,
            titleColor: Colors.black.value));

  initSetting() async {
    var content = await iconSave.get("content") ?? 14;
    var title = await iconSave.get("title") ?? 17;
    var colBox = await iconSave.get("boxcolor") ?? Colors.black.value;
    emit(state.copyWith(
        fontsizeContent: content, fontsizeTitle: title, titleColor: colBox));
  }

  changeTitle(double value) {
    emit(state.copyWith(fontsizeTitle: value.toInt()));
  }

  changeContent(double value) {
    emit(state.copyWith(fontsizeContent: value.toInt()));
  }

  changeTitleColor(int color) {
    emit(state.copyWith(titleColor: color));
  }

  changeFontFamily(String font) {
    emit(state.copyWith(fontFamily: font));
  }
}
