import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';

class CommonAppbar {
  static var view = Get.put(SearchControllerMain());
  static AppBar appBar(BuildContext context, {bool isCickMode = false}) {
    return AppBar(
      backgroundColor: ConstColor.baseColor,
      centerTitle: true,
      title: GetBuilder<SearchControllerMain>(
        init: SearchControllerMain(),
        builder: (controller) {
          return !controller.model.isSearchMode
              ? DelayedWidget(
                  delayDuration: const Duration(milliseconds: 300),
                  child: (!isCickMode
                      ? Assets.images.logoTx2.image()
                      : Assets.images.iraqPalmIcon.image()),
                )
              : const SizedBox();
        },
      ),
      leading: GetBuilder<SearchControllerMain>(
        init: SearchControllerMain(),
        builder: (controller) {
          if (controller.model.isSearchMode) {
            return const SizedBox();
          }
          return DelayedWidget(
            delayDuration: const Duration(milliseconds: 300),
            animation: DelayedAnimations.SLIDE_FROM_RIGHT,
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(8),
              decoration: decor(),
              child: Builder(builder: (context) {
                return IconButton(
                  icon: Assets.images.menu.image(),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
            ),
          );
        },
      ),
      actions: [
        GetBuilder<SearchControllerMain>(
          init: SearchControllerMain(),
          builder: (controller) {
            if (controller.model.isSearchMode) {
              return textFeild(context);
            }
            return DelayedWidget(
              delayDuration: const Duration(milliseconds: 300),
              animation: DelayedAnimations.SLIDE_FROM_LEFT,
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(8),
                decoration: decor(),
                child: IconButton(
                  icon: Assets.images.search.image(),
                  onPressed: () {
                    controller.changeState();
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  static Widget textFeild(BuildContext context) {
    return SizedBox(
      width: EsaySize.width(context),
      height: 38,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: DelayedWidget(
          delayDuration: const Duration(milliseconds: 300),
          child: TextField(
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: ConstColor.baseColor,
            cursorHeight: 15,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstColor.baseColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: ConstColor.baseColor)),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: IconButton(
                  onPressed: () {
                    view.changeState();
                  },
                  icon: const Icon(Icons.close)),
            ),
          ),
        ),
      ),
    );
  }

  static BoxDecoration decor() {
    return BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10));
  }
}
