import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/extensions/widget_ex.dart';
import 'package:flutter_application_1/Core/gen/fonts.gen.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Features/Search/view/view-search.dart';
import 'package:flutter_application_1/Features/settings/cubit/settings_cubit.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_application_1/Core/widgets/costum_drawer.dart';
import 'package:flutter_application_1/Core/widgets/coustom-appbar.dart';
import 'package:flutter_application_1/Core/widgets/navbar.dart';
import 'package:flutter_application_1/Features/Search/controller/search_controller.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  double fontfamilyNumber = 1;
  String fontFamilyWord = FontFamily.vazir;

  final TextEditingController textEditingController = TextEditingController();
  final List<int> colorsList = [
    Colors.red.value,
    Colors.black.value,
    Colors.amber.value,
    Colors.pinkAccent.value,
    Colors.purple.value,
    Colors.brown.value,
    Colors.deepOrange.value,
    Colors.blue.value,
    Colors.green.value,
    Colors.yellow.value,
    Colors.indigo.value,
    Colors.teal.value,
    Colors.lime.value,
    Colors.blueGrey.value,
    Colors.lightBlue.shade200.value,
    Colors.white.value
  ];
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(context),
        appBar: CommonAppbar.appBar(context,
            textEditingController: textEditingController),
        body: GetBuilder<SearchControllerMain>(
          builder: (controller) {
            return !controller.model.isSearchMode
                ? SingleChildScrollView(
                    child: Container(
                    color: Colors.white,
                    width: EsaySize.width(context),
                    height: EsaySize.height(context),
                    child: Column(
                      children: [
                        fontFamily(context),
                        fontsizeTitle(context),
                        fontsizeContent(context),
                        boxColor(context),
                      ],
                    ),
                  ))
                : const ViewSearch();
          },
        ),
      ),
    );
  }

  Container fontFamily(BuildContext context) {
    return costumContainer(context,
        StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          EsaySize.gap(10),
          const Icon(
            FontAwesomeIcons.font,
            size: 30,
            color: Colors.black,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: SliderTheme(
              data: const SliderThemeData(
                activeTrackColor: Colors.black,
                trackHeight: 1,
                inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                thumbColor: Colors.black,
                inactiveTickMarkColor: Colors.grey,
                activeTickMarkColor: Colors.transparent,
              ),
              child: Slider(
                divisions: 2,
                value: fontfamilyNumber,
                min: 0,
                max: 2,
                onChanged: (value) {
                  setState(
                    () {
                      switch (value) {
                        case 0:
                          fontFamilyWord = FontFamily.arabic;
                          break;
                        case 1:
                          fontFamilyWord = FontFamily.vazir;
                          break;
                        case 2:
                          fontFamilyWord = FontFamily.salamat;
                          break;
                        default:
                      }
                      BlocProvider.of<SettingsCubit>(context)
                          .changeFontFamily(fontFamilyWord);
                      fontfamilyNumber = value;
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ".readyText(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: fontFamilyWord)),
          )
        ],
      );
    }));
  }

  Widget fontsizeTitle(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return costumContainer(
            context,
            Column(
              children: [
                EsaySize.safeGap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: "العنوان :".readyText(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: EsaySize.width(context) * 0.37),
                      child: const Icon(
                        Icons.text_fields,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliderTheme(
                    data: const SliderThemeData(
                        activeTrackColor: Colors.black,
                        trackHeight: 1,
                        inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                        thumbColor: Colors.black,
                        inactiveTickMarkColor: Colors.grey,
                        activeTickMarkColor: Colors.transparent,
                        valueIndicatorColor: Colors.grey),
                    child: Slider(
                      divisions: 11,
                      value: state.fontsizeTitle.toDouble(),
                      min: 10,
                      max: 21,
                      onChanged: (value) {
                        BlocProvider.of<SettingsCubit>(context)
                            .changeTitle(value);
                        iconSave.put("title", value.toInt());
                      },
                      label: '${state.fontsizeTitle}',
                    ),
                  ),
                ),
                Expanded(
                  child: "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ".readyText(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: state.fontsizeTitle.toDouble())),
                )
              ],
            ));
      },
    );
  }

  Widget fontsizeContent(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return costumContainer(
            context,
            Column(
              children: [
                EsaySize.gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: "النص :".readyText(
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: EsaySize.width(context) * 0.37),
                      child: const Icon(
                        Icons.text_fields,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliderTheme(
                    data: const SliderThemeData(
                        activeTrackColor: Colors.black,
                        trackHeight: 1,
                        inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                        thumbColor: Colors.black,
                        inactiveTickMarkColor: Colors.grey,
                        activeTickMarkColor: Colors.transparent,
                        valueIndicatorColor: Colors.grey),
                    child: Slider(
                      divisions: 11,
                      label: state.fontsizeContent.toString(),
                      value: state.fontsizeContent.toDouble(),
                      min: 10,
                      max: 21,
                      onChanged: (value) {
                        iconSave.put("content", value.toInt());
                        BlocProvider.of<SettingsCubit>(context)
                            .changeContent(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ".readyText(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: state.fontsizeContent.toDouble())),
                )
              ],
            ));
      },
    );
  }

  Widget boxColor(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return costumContainer(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EsaySize.safeGap(1),
                const Icon(
                  FontAwesomeIcons.brush,
                  size: 30,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    colorDialog(context: context, colorsList: colorsList);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(state.titleColor),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Expanded(
                  child: "العنوان".readyText(
                      style: TextStyle(
                          color: Color(state.titleColor), fontSize: 15)),
                ),
              ],
            ));
      },
    );
  }

  Container costumContainer(BuildContext context, Widget child) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: EsaySize.width(context) * 0.8,
      height: EsaySize.height(context) * 0.17,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
          borderRadius: BorderRadius.circular(8),
          color: ConstColor.menuColor),
      child: child,
    );
  }

  Future<dynamic> colorDialog({
    required List<int> colorsList,
    required BuildContext context,
  }) {
    return showDialog(
      builder: (context) {
        int? col;

        return AlertDialog(
          title: const Text(
            "اختيار اللون",
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Wrap(
            children: colorsList
                .map((e) => GestureDetector(
                      onTap: () {
                        col = e;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        color: Color(e),
                        width: 80,
                        height: 40,
                      ),
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (col != null) {
                  BlocProvider.of<SettingsCubit>(context)
                      .changeTitleColor(col!);
                  iconSave.put("boxcolor", col);
                }
                Navigator.pop(context);
              },
              child: const Text(
                "نعم",
                textDirection: TextDirection.rtl,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "لا",
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        );
      },
      context: context,
    );
  }
}
