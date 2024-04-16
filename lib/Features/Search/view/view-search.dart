import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/const/const_method.dart';
import 'package:nakhil/Core/services/fetchContentApi/cubit/content_cubit.dart';
import 'package:nakhil/Core/services/fetchSearch/cubit/search_cubit.dart';
import 'package:nakhil/Core/services/fetchSearch/cubit/status.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/utils/loading.dart';
import 'package:nakhil/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:nakhil/Features/Search/model/model_save_value_search.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';

class ViewSearch extends StatefulWidget {
  const ViewSearch({super.key});

  @override
  State<ViewSearch> createState() => _ViewSearchState();
}

class _ViewSearchState extends State<ViewSearch> {
  late ScrollController scrollController;
  @override
  void initState() {
    Art.isAretMode = false;

    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    BlocProvider.of<SearchCubit>(context).loadMore(
        categoryID: 0,
        controller: scrollController,
        sctitle: SearchValue.sctitle,
        sctxt: SearchValue.sctxt,
        sw: SearchValue.sw);
  }

  int title = 1;
  int content = 1;
  bool titleBool = true;
  bool contentBool = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        page(context),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state.status is LoadingSearch) {
              return Center(child: CostumLoading.fadingCircle(context));
            }
            if (state.status is InitSearch) {
              return const SizedBox();
            }
            if (state.status is ErrorSearch) {
              return const Center(child: Text("Error"));
            }

            if (state.status is ComplateSearch) {
              var data = state.news;
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      controller: scrollController,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return BlocBuilder<ControllerApp, NaVconState>(
                          builder: (context, state) {
                            return NewsItem(
                              id: data[index].id!,
                              time: FormatData.result(data[index].dateTime!),
                              title: data[index].title!,
                              path:
                                  "${COnstMethod().baseImageUrlLow(context: context)}${data[index].img}",
                            );
                          },
                        );
                      },
                    )),
                    if (state.isLoadMoreRunning)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CostumLoading.fadingCircle(context),
                        ),
                      ),
                    if (!state.hasNextPage) const SizedBox.shrink(),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Container page(BuildContext context) {
    return Container(
      width: EsaySize.width(context),
      height: 80,
      decoration: BoxDecoration(
          color: ConstColor.baseColor, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              height: 1,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: chekBox("النص", contentBool, (p0) {
                    setState(() {
                      contentBool = p0!;
                      p0 ? SearchValue.sctxt = 1 : SearchValue.sctxt = 0;
                    });
                  }),
                ),
                EsaySize.gap(8),
                chekBox("العنوان", titleBool, (p0) {
                  setState(() {
                    titleBool = p0!;
                    p0 ? SearchValue.sctitle = 1 : SearchValue.sctitle = 0;
                  });
                }),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Row chekBox(String txt, bool modeBool, void Function(bool?)? changed) {
    return Row(
      children: [
        Text(txt),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 20,
          height: 20,
          child: Transform.scale(
            scale: 0.85,
            child: Checkbox(
              side: BorderSide.none,
              fillColor: MaterialStatePropertyAll(ConstColor.baseColor),
              shape: const BeveledRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              value: modeBool,
              onChanged: changed,
            ),
          ),
        )
      ],
    );
  }
}
