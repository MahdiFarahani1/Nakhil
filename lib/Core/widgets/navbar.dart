import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Features/home/controller/nav_index.dart';
import 'package:nakhil/Features/home/view/nakhil_home.dart';
import 'package:nakhil/Features/info/view_info.dart';
import 'package:nakhil/Features/save/view_save.dart';
import 'package:nakhil/Features/settings/view_settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBarCommon {
  static Widget navigation() {
    return GetBuilder<NavController>(
      init: NavController(),
      initState: (_) {},
      builder: (controller) {
        return SalomonBottomBar(
          itemShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: (p) {
            controller.changeState(p);
            switch (p) {
              case 0:
                Get.to(const NakhilHome(), transition: Transition.leftToRight);
                break;
              case 1:
                Get.to(SaveNews(), transition: Transition.leftToRight);
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
          backgroundColor: ConstColor.baseColor,
          items: [
            SalomonBottomBarItem(
                selectedColor: ConstColor.itemBackground,
                icon: navItem(Assets.images.iraqPalmIcon.image(), 0,
                    controller.model.index),
                title: const Text(
                  "نخیل عربی",
                  style: TextStyle(color: Colors.white),
                )),
            SalomonBottomBarItem(
                selectedColor: ConstColor.itemBackground,
                icon: navItem(
                    Assets.images.saves.image(), 1, controller.model.index),
                title: const Text("نخیل عربی")),
            SalomonBottomBarItem(
                selectedColor: ConstColor.itemBackground,
                icon: navItem(
                    Assets.images.settings.image(), 2, controller.model.index),
                title: const Text("نخیل عربی")),
            SalomonBottomBarItem(
                selectedColor: ConstColor.itemBackground,
                icon: navItem(
                    Assets.images.about.image(), 3, controller.model.index),
                title: const Text("الله یا"))
          ],
        );
      },
    );
  }

  static Widget navItem(Widget path, int index, int selectIndex) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
              color: index == selectIndex ? Colors.green : Colors.white,
              width: 1),
          color: const Color.fromRGBO(38, 83, 121, 0.63),
          borderRadius: BorderRadius.circular(10)),
      child: path,
    );
  }
}
