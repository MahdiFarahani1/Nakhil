import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/services/fetchSearch/cubit/search_cubit.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/model/model_save_value_search.dart';

class CommonAppbar {
  static var view = Get.put(SearchControllerMain());
  static AppBar appBar(BuildContext context,
      {bool isCickMode = false,
      required TextEditingController textEditingController}) {
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
          if (controller.model.isSearchMode && !isCickMode) {
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
            if (controller.model.isSearchMode && !isCickMode) {
              return Builder(builder: (context) {
                SearchValue.sctitle = 1;
                SearchValue.sctxt = 1;
                return textFeild(context, textEditingController, isCickMode);
              });
            }
            return !isCickMode
                ? DelayedWidget(
                    delayDuration: const Duration(milliseconds: 300),
                    animation: DelayedAnimations.SLIDE_FROM_LEFT,
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.all(8),
                      decoration: decor(),
                      child: IconButton(
                        icon: !isCickMode
                            ? Assets.images.search.image()
                            : const SizedBox(),
                        onPressed: () {
                          !isCickMode ? controller.changeState() : null;
                        },
                      ),
                    ),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }

  static Widget textFeild(
      BuildContext context, TextEditingController txt, bool isClick) {
    return SizedBox(
      width: EsaySize.width(context),
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: DelayedWidget(
          delayDuration: const Duration(milliseconds: 300),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return TextField(
                onChanged: (value) {
                  SearchValue.sw = value;
                },
                controller: txt,
                onSubmitted: (value) {
                  BlocProvider.of<SearchCubit>(context).search(
                      start: 0,
                      sw: SearchValue.sw,
                      sctitle: SearchValue.sctitle,
                      sctxt: SearchValue.sctxt,
                      categoryID: SearchValue.categoryID);
                },
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
                        if (isClick) {}
                        view.changeState();
                        txt.clear();
                        BlocProvider.of<SearchCubit>(context).initPage();
                      },
                      icon: const Icon(Icons.close)),
                ),
              );
            },
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
