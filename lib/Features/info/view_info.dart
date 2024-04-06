import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nakhil/Core/const/const_color.dart';
import 'package:nakhil/Core/extensions/widget_ex.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';

import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/Search/controller/search_controller.dart';
import 'package:nakhil/Features/Search/view/view-search.dart';

class Info extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  Info({super.key});

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
                ? Container(
                    color: ConstColor.baseColor,
                    width: EsaySize.width(context),
                    height: EsaySize.height(context),
                    child: "Info".readyText(),
                  )
                : const ViewSearch();
          },
        ),
      ),
    );
  }
}
