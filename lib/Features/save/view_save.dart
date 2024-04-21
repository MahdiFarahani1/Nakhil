import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/utils/format_date.dart';
import 'package:flutter_application_1/Core/widgets/costum_drawer.dart';
import 'package:flutter_application_1/Core/widgets/coustom-appbar.dart';
import 'package:flutter_application_1/Core/widgets/navbar.dart';
import 'package:flutter_application_1/Features/Search/controller/search_controller.dart';
import 'package:flutter_application_1/Features/Search/view/view-search.dart';
import 'package:flutter_application_1/Features/home/widgets/news/news-item.dart';
import 'package:flutter_application_1/Features/save/cubit/save_news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SaveNews extends StatefulWidget {
  const SaveNews({super.key});

  @override
  State<SaveNews> createState() => _SaveNewsState();
}

class _SaveNewsState extends State<SaveNews> {
  @override
  void initState() {
    BlocProvider.of<SaveNewsCubit>(context).loadSave(context);

    super.initState();
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(context),
        appBar: CommonAppbar.appBar(context,
            textEditingController: textEditingController),
        body: GetBuilder<SearchControllerMain>(
          builder: (controller) {
            return !controller.model.isSearchMode
                ? BlocBuilder<SaveNewsCubit, SaveNewsState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
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
