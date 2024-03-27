import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Features/home/controller/nav_index.dart';
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

  static Container navItem(Widget path, int index, int selectIndex) {
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
