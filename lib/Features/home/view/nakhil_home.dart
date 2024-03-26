import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/gen/assets.gen.dart';
import 'package:nakhil/Core/services/fetchAll/fetch_all_api.dart';
import 'package:nakhil/Core/services/fetchAll/models/title_news_model.dart';

import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Features/home/controller/nav_index.dart';
import 'package:nakhil/Features/home/controller/slider_images.dart';
import 'package:nakhil/Features/home/widgets/category/category-item.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NakhilHome extends StatefulWidget {
  static String rn = "/nakhilhome";
  const NakhilHome({super.key});

  @override
  State<NakhilHome> createState() => _NakhilHomeState();
}

class _NakhilHomeState extends State<NakhilHome> {
  var view = Get.put(ServiceController());
  @override
  void initState() {
    view.fetchData();
    super.initState();
  }

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
        if (controller.status is Loading) {
          return Expanded(
              child: Container(
                  width: EsaySize.width(context),
                  child: CostumLoading.fadingCircle(context)));
        }
        if (controller.status is Complete) {
          var data = controller.data as TitleNewsModel;

          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(
                  time: FormatData.result(data.posts![index].dateTime!),
                  title: data.posts![index].title!,
                  path:
                      "${COnstMethod.baseImageUrlLow}${data.posts![index].img!}",
                );
              },
              itemCount: 20,
            ),
          );
        }
        if (controller.status is Error) {
          return const Center(child: Text("Error"));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget sliderImages(BuildContext context) {
    return GetBuilder<ServiceController>(
      builder: (controller) {
        if (controller.status is Complete) {
          var data = controller.data as TitleNewsModel;
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
                    int apiIndex = data.posts!.length - 4 + index;

                    return SizedBox(
                      height: EsaySize.height(context) / 4,
                      width: EsaySize.width(context),
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              width: EsaySize.width(context),
                              height: EsaySize.height(context) / 4,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return CostumLoading.loadCircle(context);
                              },
                              imageUrl:
                                  "${COnstMethod.baseImageUrlHight}${data.posts![apiIndex].img!}"),
                        ),
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
                                  decoration: 8.0.decor(const Color.fromRGBO(
                                      255, 255, 255, 0.18)),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: EsaySize.width(context) * 0.5,
                                        height: EsaySize.height(context) / 18,
                                        child: Text(
                                          data.posts![apiIndex].title!,
                                          maxLines: 2,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  margin: 0.0.padAllConst(),
                                  width: 42,
                                  height: (EsaySize.height(context) / 4) / 3,
                                  decoration: 8.0.decor(const Color.fromRGBO(
                                      255, 255, 255, 0.18)),
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
        if (controller.status is Loading) {
          return Expanded(
              child: SizedBox(
                  width: EsaySize.width(context),
                  child: CostumLoading.loadLine(context)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget navigation() {
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
    ButtonStyle styleBtn() {
      return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          fixedSize: const Size(130, 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))));
    }

    TextStyle stlebtnText() {
      return const TextStyle(color: Colors.black);
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Builder(builder: (context) {
        return Container(
          width: EsaySize.width(context) / 1.8,
          height: EsaySize.height(context) -
              (Scaffold.of(context).appBarMaxHeight!),
          decoration: 10.0.decor(ConstColor.itemBackground),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10)),
                    color: ConstColor.baseColor,
                  ),
                  width: EsaySize.width(context) / 1.8,
                  height: 220,
                  child: Assets.images.mainLogo.image(),
                ),
              ),
              EsaySize.gap(25),
              ElevatedButton(
                onPressed: () {},
                style: styleBtn(),
                child: Text(
                  "الرئيسية",
                  style: stlebtnText(),
                ),
              ),
              EsaySize.gap(8),
              ElevatedButton(
                onPressed: () {},
                style: styleBtn(),
                child: Text(
                  "الاخبار",
                  style: stlebtnText(),
                ),
              ),
              EsaySize.gap(8),
              ElevatedButton(
                onPressed: () {},
                style: styleBtn(),
                child: Text(
                  "المقالات",
                  style: stlebtnText(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
