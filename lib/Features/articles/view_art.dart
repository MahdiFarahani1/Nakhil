import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/extensions/layout_ex.dart';
import 'package:nakhil/Core/services/fetchContentApi/cubit/content_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/status.dart';
import 'package:nakhil/Core/services/news_cubit/slider-bloc/slider_p_cubit.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';
import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/view/view-search.dart';
import 'package:nakhil/Features/click_news/view/Main_news_page.dart';
import 'package:nakhil/Features/home/cubit/nav_cubit.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';

// ignore: must_be_immutable
class ViewArt extends StatefulWidget {
  ViewArt({super.key});

  @override
  State<ViewArt> createState() => _ViewArtState();
}

class _ViewArtState extends State<ViewArt> {
  final CarouselController controller = CarouselController();
  @override
  void initState() {
    Art.isAretMode = true;
    BlocProvider.of<NewsCubit>(context)
        .fetchData(start: 0, limit: 20, catId: 0, isArt: true);
    BlocProvider.of<SliderPCubit>(context).fetchArtSlider();

    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: CostumDrawer.customDrawer(context),
        appBar: CommonAppbar.appBar(context,
            textEditingController: textEditingController),
        bottomNavigationBar: NavBarCommon.navigation(),
        body: GetBuilder<SearchControllerMain>(
          init: SearchControllerMain(),
          initState: (_) {},
          builder: (controller) {
            return !controller.model.isSearchMode
                ? Column(
                    children: [
                      sliderImages(
                        context,
                      ),
                      // BlocBuilder<SelectCategoryCubit, SelectCategoryState>(
                      //   builder: (context, state) {
                      //     return Cat().category(
                      //         context, state.selectIndex, state.boolList);
                      //   },
                      // ),
                      news()
                    ],
                  )
                : const ViewSearch();
          },
        ),
      ),
    );
  }

  Widget sliderImages(BuildContext context) {
    return BlocBuilder<SliderPCubit, SliderPState>(
      builder: (context, stateNews) {
        if (stateNews.status is CompleteSlider) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<NavCubit, NavState>(
              builder: (context, state) {
                return CarouselSlider.builder(
                  carouselController: controller,
                  options: CarouselOptions(
                    height: EsaySize.height(context) / 4,
                    aspectRatio: 9 / 16,
                    viewportFraction: 1,
                    initialPage: state.index,
                    autoPlay: true,
                    reverse: true,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index, realIndex) {
                    return SizedBox(
                      height: EsaySize.height(context) / 4,
                      width: EsaySize.width(context),
                      child: Stack(children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              MainPage(id: stateNews.sliderData?[index]["id"]),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                                width: EsaySize.width(context),
                                height: EsaySize.height(context) / 4,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return CostumLoading.loadCircle(context);
                                },
                                imageUrl:
                                    "${COnstMethod.baseImageUrlHight}${stateNews.sliderData?[index]["img"]}"),
                          ),
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
                                        BlocProvider.of<NavCubit>(context)
                                            .nextPage(controller);
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
                                          stateNews.sliderData?[index]["title"],
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
                                        BlocProvider.of<NavCubit>(context)
                                            .previousPage(controller);
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
        if (stateNews.status is LoadingSlider) {
          return Expanded(
              child: SizedBox(
                  width: EsaySize.width(context),
                  child: CostumLoading.loadLine(context)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Expanded news() {
    return Expanded(child: BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state.status is LoadingA) {
          return SizedBox(
            width: EsaySize.width(context),
            child: CostumLoading.fadingCircle(context),
          );
        }
        if (state.status is CompleteA) {
          var data = state.data;

          return Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    //    controller: scrollController,
                    itemBuilder: (context, index) {
                      return NewsItem(
                        id: data![index].id!,
                        time: FormatData.result(data[index].dateTime!),
                        title: data[index].title!,
                        path:
                            "${COnstMethod.baseImageUrlLow}${data[index].img!}",
                      );
                    },
                    itemCount: data?.length,
                  ),
                ),
              ),
              if (state.isLoadMoreRunning)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CostumLoading.fadingCircle(context),
                )
            ],
          );
        }
        if (state.status is ErrorA) {
          return const Center(child: Text("Error"));
        }
        return const SizedBox.shrink();
      },
    ));
  }
}
