import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/services/fetchContentApi/cubit/content_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/news_cubit.dart';
import 'package:nakhil/Core/services/news_cubit/cubit/status.dart';
import 'package:nakhil/Core/utils/category.dart';

import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';

import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/view/view-search.dart';
import 'package:nakhil/Features/home/widgets/category/all_category.dart';
import 'package:nakhil/Features/home/widgets/cubit/select_category_cubit.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  int selectIndex = 0;
  List<bool> boolList = List.generate(categoryId.length, (index) => false);

  final TextEditingController textEditingController = TextEditingController();
  late ScrollController scrollController;
  @override
  void initState() {
    Art.isAretMode = false;

    BlocProvider.of<NewsCubit>(context).fetchData(
        start: 0,
        limit: 20,
        catId: BlocProvider.of<SelectCategoryCubit>(context).state.catId);

    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    BlocProvider.of<NewsCubit>(context).loadMore(scrollController,
        BlocProvider.of<SelectCategoryCubit>(context).state.catId);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          drawer: CostumDrawer.customDrawer(context),
          bottomNavigationBar: NavBarCommon.navigation(),
          appBar: CommonAppbar.appBar(context,
              textEditingController: textEditingController),
          body: GetBuilder<SearchControllerMain>(
            builder: (controller) {
              return !controller.model.isSearchMode
                  ? Column(
                      children: [
                        EsaySize.gap(7),
                        BlocBuilder<SelectCategoryCubit, SelectCategoryState>(
                          builder: (context, state) {
                            return Cat().category(
                                context, state.selectIndex, state.boolList);
                          },
                        ),
                        EsaySize.gap(7),
                        Expanded(child: BlocBuilder<NewsCubit, NewsState>(
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
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      width: double.infinity,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        itemBuilder: (context, index) {
                                          return NewsItem(
                                            id: data![index].id!,
                                            time: FormatData.result(
                                                data[index].dateTime!),
                                            title: data[index].title!,
                                            path:
                                                "${COnstMethod.baseImageUrlLow}${data[index].img}",
                                          );
                                        },
                                        itemCount: data?.length,
                                      ),
                                    ),
                                  ),
                                  if (state.isLoadMoreRunning)
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child:
                                          CostumLoading.fadingCircle(context),
                                    )
                                ],
                              );
                            }
                            if (state.status is ErrorA) {
                              return const Center(child: Text("Error"));
                            }
                            return const SizedBox.shrink();
                          },
                        ))
                      ],
                    )
                  : const ViewSearch();
            },
          )),
    );
  }
}
