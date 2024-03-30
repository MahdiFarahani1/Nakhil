import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/services/fetchAll/fetch_all_api.dart';
import 'package:nakhil/Core/services/fetchAll/model/title_news_model.dart';

import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';
import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/home/controller/slider_images.dart';
import 'package:nakhil/Features/home/widgets/category/all_category.dart';
import 'package:nakhil/Features/home/widgets/news/all_news.dart';

class NakhilHome extends StatefulWidget {
  const NakhilHome({super.key});

  @override
  State<NakhilHome> createState() => _NakhilHomeState();
}

class _NakhilHomeState extends State<NakhilHome> {
  var view = Get.put(ServiceController());
  var view2 = Get.put(SearchControllerMain());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(context),
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(),
        body: Column(
          children: [
            sliderImages(context),
            Cat.category(context),
            AllNews.news(context)
          ],
        ),
      ),
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
}
