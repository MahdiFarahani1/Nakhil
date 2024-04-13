import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/utils/format_date.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';

import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/view/view-search.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';
import 'package:nakhil/Features/save/cubit/save_news_cubit.dart';

class SaveNews extends StatelessWidget {
  SaveNews({super.key});

  final TextEditingController textEditingController = TextEditingController();

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
                ? BlocBuilder<SaveNewsCubit, SaveNewsState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          BlocProvider.of<SaveNewsCubit>(context)
                              .loadSave(index);
                          return NewsItem(
                              path: state.savedItem[index].img,
                              title: state.savedItem[index].title,
                              time: FormatData.result(
                                  state.savedItem[index].time),
                              id: state.savedItem[index].id);
                        },
                        itemCount: state.savedItem.length,
                      );
                    },
                  )
                : const ViewSearch();
          },
        ),
      ),
    );
  }
}
