import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/widget_ex.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';

import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/view/view-search.dart';
import 'package:nakhil/Features/settings/cubit/settings_cubit.dart';

class Settings extends StatelessWidget {
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
        bottomNavigationBar: NavBarCommon.navigation(),
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
    return costumContainer(
        context,
        Column(
          children: [
            EsaySize.gap(10),
            const Icon(
              FontAwesomeIcons.font,
              size: 30,
              color: Colors.white,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: SliderTheme(
                data: const SliderThemeData(
                  activeTrackColor: Colors.white,
                  trackHeight: 1,
                  inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                  thumbColor: Colors.white,
                  inactiveTickMarkColor: Colors.grey,
                  activeTickMarkColor: Colors.transparent,
                ),
                child: Slider(
                  divisions: 3,
                  value: 1,
                  min: 1,
                  max: 3,
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ".readyText(
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            )
          ],
        ));
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
                              color: Colors.white, fontSize: 15)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: EsaySize.width(context) * 0.37),
                      child: const Icon(
                        Icons.text_fields,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliderTheme(
                    data: const SliderThemeData(
                        activeTrackColor: Colors.white,
                        trackHeight: 1,
                        inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                        thumbColor: Colors.white,
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
                      },
                      label: '${state.fontsizeTitle}',
                    ),
                  ),
                ),
                Expanded(
                  child: "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ".readyText(
                      style: TextStyle(
                          color: Colors.white,
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
                              color: Colors.white, fontSize: 15)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: EsaySize.width(context) * 0.37),
                      child: const Icon(
                        Icons.text_fields,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SliderTheme(
                    data: const SliderThemeData(
                        activeTrackColor: Colors.white,
                        trackHeight: 1,
                        inactiveTrackColor: Color.fromRGBO(158, 158, 158, 1),
                        thumbColor: Colors.white,
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
                        BlocProvider.of<SettingsCubit>(context)
                            .changeContent(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ".readyText(
                      style: TextStyle(
                          color: Colors.white,
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
                  color: Colors.white,
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
          borderRadius: BorderRadius.circular(8), color: ConstColor.menuColor),
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
