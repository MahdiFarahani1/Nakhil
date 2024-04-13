part of 'settings_cubit.dart';

class SettingsState {
  int fontsizeTitle;
  int fontsizeContent;
  int titleColor;
  SettingsState(
      {required this.fontsizeContent,
      required this.fontsizeTitle,
      required this.titleColor});

  SettingsState copyWith(
      {int? fontsizeTitle, int? fontsizeContent, int? titleColor}) {
    return SettingsState(
        fontsizeContent: fontsizeContent ?? this.fontsizeContent,
        fontsizeTitle: fontsizeTitle ?? this.fontsizeTitle,
        titleColor: titleColor ?? this.titleColor);
  }
}
