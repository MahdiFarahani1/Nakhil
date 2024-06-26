import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/gen/assets.gen.dart';
import 'package:flutter_application_1/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/Features/home/controller/nav_index.dart';
import 'package:flutter_application_1/Features/home/view/nakhil_home.dart';
import 'package:flutter_application_1/Features/home/widgets/cubit/select_category_cubit.dart';
import 'package:flutter_application_1/Features/info/view_info.dart';
import 'package:flutter_application_1/Features/save/view_save.dart';
import 'package:flutter_application_1/Features/settings/view_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBarCommon {
  static Widget navigation(BuildContext context) {
    return bloc.BlocBuilder<ControllerApp, NaVconState>(
      builder: (context, state) {
        return GetBuilder<NavController>(
          init: NavController(),
          initState: (_) {},
          builder: (controller) {
            return SalomonBottomBar(
              itemShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onTap: (p) {
                controller.changeState(p);
                switch (p) {
                  case 0:
                    bloc.BlocProvider.of<ControllerApp>(context).changeState();
                    bloc.BlocProvider.of<SelectCategoryCubit>(context)
                        .initState(context);
                    bloc.BlocProvider.of<NewsCubit>(context).fetchData(
                        context: context, start: 0, limit: 20, catId: 0);
                    Get.to(const NakhilHome(),
                        transition: Transition.leftToRight);
                    break;
                  case 1:
                    Get.to(const SaveNews(),
                        transition: Transition.leftToRight);
                    break;
                  case 2:
                    Get.to(Settings(), transition: Transition.leftToRight);
                    break;
                  case 3:
                    Get.to(Info(), transition: Transition.leftToRight);
                    break;
                  default:
                }
              },
              itemPadding: const EdgeInsets.all(10),
              currentIndex: controller.model.index,
              backgroundColor: state.status is Araghi
                  ? ConstColor.baseColor
                  : ColorNakhil.bg,
              items: [
                SalomonBottomBarItem(
                    selectedColor: state.status is Araghi
                        ? ConstColor.itemBackground
                        : ColorNakhil.item,
                    icon: bloc.BlocBuilder<ControllerApp, NaVconState>(
                      builder: (context, state) {
                        if (state.status is Araghi) {
                          return navItem(Assets.images.araghi.image(), 0,
                              controller.model.index);
                        }
                        return navItem(Assets.images.nnews.image(), 0,
                            controller.model.index);
                      },
                    ),
                    title: bloc.BlocBuilder<ControllerApp, NaVconState>(
                      builder: (context, state) {
                        if (state.status is Araghi) {
                          return const Text(
                            "نخيل نيوز",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }
                        return Text(
                          "نخيل عراقي",
                          style: TextStyle(
                            color: ColorNakhil.item,
                          ),
                        );
                      },
                    )),
                SalomonBottomBarItem(
                    selectedColor: state.status is Araghi
                        ? ConstColor.itemBackground
                        : ColorNakhil.item,
                    icon: navItem(
                        Icon(
                          Icons.bookmark,
                          color: state.status is Araghi
                              ? ConstColor.baseColor
                              : ColorNakhil.bg,
                          size: 30,
                        ),
                        1,
                        controller.model.index),
                    title: Text("المفضلة", style: NavBarCommon.textStyle())),
                SalomonBottomBarItem(
                    selectedColor: state.status is Araghi
                        ? ConstColor.itemBackground
                        : ColorNakhil.item,
                    icon: navItem(
                        Icon(
                          Icons.settings,
                          color: state.status is Araghi
                              ? ConstColor.baseColor
                              : ColorNakhil.bg,
                          size: 30,
                        ),
                        2,
                        controller.model.index),
                    title: Text(
                      "الاعدادات",
                      style: NavBarCommon.textStyle(),
                    )),
                SalomonBottomBarItem(
                    selectedColor: state.status is Araghi
                        ? ConstColor.itemBackground
                        : ColorNakhil.item,
                    icon: navItem(
                        Icon(
                          Icons.info,
                          color: state.status is Araghi
                              ? ConstColor.baseColor
                              : ColorNakhil.bg,
                          size: 30,
                        ),
                        3,
                        controller.model.index),
                    title: Text("حول التطبيق", style: NavBarCommon.textStyle()))
              ],
            );
          },
        );
      },
    );
  }

  static TextStyle textStyle() {
    return const TextStyle();
  }

  static Widget navItem(Widget path, int index, int selectIndex) {
    return bloc.BlocBuilder<ControllerApp, NaVconState>(
      builder: (context, state) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(
                  color: index == selectIndex ? Colors.green : Colors.grey,
                  width: 1),
              color: state.status is Nnews ? ColorNakhil.item : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: path,
        );
      },
    );
  }
}
