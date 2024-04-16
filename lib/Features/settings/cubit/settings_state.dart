part of 'settings_cubit.dart';

class SettingsState {
  int fontsizeTitle;
  int fontsizeContent;
  int titleColor;
  String fontFamily;
  SettingsState(
      {required this.fontsizeContent,
      required this.fontsizeTitle,
      required this.titleColor,
      this.fontFamily = FontFamily.vazir});

  SettingsState copyWith(
      {int? fontsizeTitle,
      int? fontsizeContent,
      int? titleColor,
      String? fontFamily}) {
    return SettingsState(
        fontsizeContent: fontsizeContent ?? this.fontsizeContent,
        fontsizeTitle: fontsizeTitle ?? this.fontsizeTitle,
        titleColor: titleColor ?? this.titleColor,
        fontFamily: fontFamily ?? this.fontFamily);
  }
}
