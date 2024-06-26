import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/gen/assets.gen.dart';
import 'package:flutter_application_1/Core/services/fetchSearch/cubit/search_cubit.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/Features/Search/controller/search_controller.dart';
import 'package:flutter_application_1/Features/Search/model/model_save_value_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommonAppbar {
  static var view = Get.put(SearchControllerMain());
  static AppBar appBar(BuildContext context,
      {bool isCickMode = false,
      required TextEditingController textEditingController}) {
    return AppBar(
      centerTitle: true,
      title: GetBuilder<SearchControllerMain>(
        init: SearchControllerMain(),
        builder: (controller) {
          return !controller.model.isSearchMode
              ? DelayedWidget(
                  delayDuration: const Duration(milliseconds: 300),
                  child: (!isCickMode
                      ? (BlocBuilder<ControllerApp, NaVconState>(
                          builder: (context, state) {
                            return state.status is Araghi
                                ? const Text(
                                    "نخيل عراقي",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18.5),
                                  )
                                : Text(
                                    "نخيل نيوز",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: ColorNakhil.item,
                                        fontSize: 18.5),
                                  );
                          },
                        ))
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
          return BlocBuilder<ControllerApp, NaVconState>(
            builder: (context, state) {
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
                      icon: Icon(
                        FontAwesomeIcons.barsStaggered,
                        color: state.color2,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }),
                ),
              );
            },
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
                ? BlocBuilder<ControllerApp, NaVconState>(
                    builder: (context, state) {
                      return DelayedWidget(
                        delayDuration: const Duration(milliseconds: 300),
                        animation: DelayedAnimations.SLIDE_FROM_LEFT,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.all(8),
                          decoration: decor(),
                          child: IconButton(
                            icon: !isCickMode
                                ? Transform.rotate(
                                    angle: 90 * 3.14159265359 / 180,
                                    child: Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      color: state.color2,
                                    ),
                                  )
                                : const SizedBox(),
                            onPressed: () {
                              !isCickMode ? controller.changeState() : null;
                            },
                          ),
                        ),
                      );
                    },
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
                      context: context,
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
