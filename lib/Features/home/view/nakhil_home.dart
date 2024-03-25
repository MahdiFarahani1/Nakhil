import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/services/fetchAll/fetch_all_api.dart';
import 'package:nakhil/Core/services/fetchAll/models/title_news_model.dart';

import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Features/home/controller/nav_index.dart';
import 'package:nakhil/Features/home/controller/slider_images.dart';
import 'package:nakhil/Features/home/widgets/category/category-item.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NakhilHome extends StatelessWidget {
  static String rn = "/nakhilhome";
  const NakhilHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(),
        drawer: customDrawer(context),
        bottomNavigationBar: navigation(),
        body: Column(
          children: [sliderImages(context), category(context), news(context)],
        ),
      ),
    );
  }

  SizedBox category(BuildContext context) {
    return SizedBox(
      width: EsaySize.width(context),
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const CatItem();
        },
        itemCount: 8,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget news(BuildContext context) {
    return GetBuilder<ServiceController>(
      init: ServiceController(),
      builder: (controller) {
        if (controller.status.value is Loading) {
          return Center(child: CostumLoading.fadingCircle(context));
        }
        if (controller.status.value is Complete) {
          //     var data = controller.data;

          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(
                  time: "سیشی",
                  title: "سشیسش",
                  path: "",
                );
              },
              itemCount: 20,
            ),
          );
        }
        if (controller.status.value is Error) {
          return const Center(child: Text("Error"));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Padding sliderImages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GetBuilder<SliderController>(
        init: SliderController(),
        builder: (controller) {
          return CarouselSlider.builder(
            carouselController: controller.model.carouselController,
            options: CarouselOptions(
              height: EsaySize.height(context) / 4,
              aspectRatio: 9 / 16,
              viewportFraction: 1,
              initialPage: controller.model.index,
              autoPlay: true,
              reverse: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            itemCount: 4,
            itemBuilder: (context, index, realIndex) {
              return Container(
                height: EsaySize.height(context) / 4,
                width: EsaySize.width(context),
                decoration: 10.0.decor(Color.fromARGB(
                    255,
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255))),
                child: Stack(children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(16, 15, 20, 0.3)),
                      height: (EsaySize.height(context) / 4) / 3,
                      width: EsaySize.width(context),
                      child: Row(
                        children: [
                          Container(
                            margin: 0.0.padAllConst(),
                            width: 42,
                            height: (EsaySize.height(context) / 4) / 3,
                            decoration: 8.0.decor(
                                const Color.fromRGBO(255, 255, 255, 0.18)),
                            child: IconButton(
                                onPressed: () {
                                  controller.nextPage();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "نخیل عراقی",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  index.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: 0.0.padAllConst(),
                            width: 42,
                            height: (EsaySize.height(context) / 4) / 3,
                            decoration: 8.0.decor(
                                const Color.fromRGBO(255, 255, 255, 0.18)),
                            child: IconButton(
                                onPressed: () {
                                  controller.previousPage();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            },
          );
        },
      ),
    );
  }

  Widget navigation() {
    return GetBuilder<NavController>(
      init: NavController(),
      initState: (_) {},
      builder: (controller) {
        return SalomonBottomBar(
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

  Container navItem(Widget path, int index, int selectIndex) {
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

  Widget customDrawer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Builder(builder: (context) {
        return Container(
          color: Colors.white,
          width: EsaySize.width(context) / 1.8,
          height: EsaySize.height(context) -
              (Scaffold.of(context).appBarMaxHeight!),
        );
      }),
    );
  }
}
