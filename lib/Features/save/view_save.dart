import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nakhil/Core/dataBase/model.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';

import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/view/view-search.dart';
import 'package:nakhil/Features/home/widgets/news/news-item.dart';
import 'package:nakhil/main.dart';

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
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final savedItem = box.getAt(index) as ItemDatabase;
                      return NewsItem(
                          path: savedItem.img,
                          title: savedItem.title,
                          time: savedItem.time.toString(),
                          id: savedItem.id);
                    },
                    itemCount: box.values.length,
                  )
                : const ViewSearch();
          },
        ),
      ),
    );
  }
}
