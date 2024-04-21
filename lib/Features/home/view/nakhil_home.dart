import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/extensions/layout_ex.dart';
import 'package:flutter_application_1/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:flutter_application_1/Core/services/news_cubit/cubit/status.dart';
import 'package:flutter_application_1/Features/Search/controller/search_controller.dart';
import 'package:flutter_application_1/Features/Search/view/view-search.dart';
import 'package:flutter_application_1/Features/click_news/view/Main_news_page.dart';
import 'package:flutter_application_1/Features/home/cubit/nav_cubit.dart';
import 'package:flutter_application_1/Features/home/widgets/category/all_category.dart';
import 'package:flutter_application_1/Features/home/widgets/cubit/select_category_cubit.dart';
import 'package:flutter_application_1/Features/home/widgets/news/news-item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Core/const/const_method.dart';

import 'package:flutter_application_1/Core/services/fetchContentApi/cubit/content_cubit.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/utils/format_date.dart';
import 'package:flutter_application_1/Core/utils/loading.dart';
import 'package:flutter_application_1/Core/widgets/costum_drawer.dart';
import 'package:flutter_application_1/Core/widgets/coustom-appbar.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/Core/widgets/navbar.dart';

class NakhilHome extends StatefulWidget {
  const NakhilHome({super.key});

  @override
  State<NakhilHome> createState() => _NakhilHomeState();
}

class _NakhilHomeState extends State<NakhilHome> {
  var view2 = Get.put(SearchControllerMain());
  late ScrollController scrollController;
  final CarouselController carouselController = CarouselController();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    Art.isAretMode = false;
    BlocProvider.of<NewsCubit>(context)
        .fetchData(context: context, start: 0, limit: 20, catId: 0);
    BlocProvider.of<SelectCategoryCubit>(context).initState(context);
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  void _scrollListener() {
    BlocProvider.of<NewsCubit>(context).loadMore(scrollController,
        BlocProvider.of<SelectCategoryCubit>(context).state.catId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(context,
            textEditingController: textEditingController),
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(context),
        body: GetBuilder<SearchControllerMain>(
          init: SearchControllerMain(),
          initState: (_) {},
          builder: (controller) {
            return !controller.model.isSearchMode
                ? Column(
                    children: [
                      sliderImages(context),
                      BlocBuilder<SelectCategoryCubit, SelectCategoryState>(
                        builder: (context, state) {
                          return Cat().category(
                              context, state.selectIndex, state.boolList);
                        },
                      ),
                      news()
                    ],
                  )
                : const ViewSearch();
          },
        ),
      ),
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
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return NewsItem(
                        id: data![index].id!,
                        time: FormatData.result(data[index].dateTime!),
                        title: data[index].title!,
                        path:
                            "${BlocProvider.of<ControllerApp>(context).state.status is Nnews ? "https://palms-news.com/upload_list/thumbs/" : "https://iraqpalm.com/upload_list/thumbs/"}${data[index].img!}",
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

  Widget sliderImages(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state.status is CompleteA) {
          var data = state.data;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<NavCubit, NavState>(
              builder: (context, state) {
                return CarouselSlider.builder(
                  carouselController: carouselController,
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
                    int apiIndex = data!.length - 4 + index;

                    return SizedBox(
                      height: EsaySize.height(context) / 4,
                      width: EsaySize.width(context),
                      child: Stack(children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                                MainPage(
                                  isArtMode: false,
                                  id: data[apiIndex].id!,
                                ),
                                arguments: false);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                                width: EsaySize.width(context),
                                height: EsaySize.height(context) / 4,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return const Center(
                                    child: Icon(Icons.error),
                                  );
                                },
                                placeholder: (context, url) {
                                  return CostumLoading.loadCircle(context);
                                },
                                imageUrl:
                                    "${COnstMethod().baseImageUrlHight(context: context)}${data[apiIndex].img!}"),
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
                                            .nextPage(carouselController);
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
                                          data[apiIndex].title!,
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
                                            .previousPage(carouselController);
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
        if (state.status is LoadingA) {
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
