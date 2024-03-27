import 'package:flutter/material.dart';
import 'package:nakhil/Core/utils/esay_size.dart';
import 'package:nakhil/Core/widgets/costum_drawer.dart';

import 'package:nakhil/Core/widgets/coustom-appbar.dart';
import 'package:nakhil/Core/widgets/navbar.dart';
import 'package:nakhil/Features/home/widgets/category/all_category.dart';
import 'package:nakhil/Features/home/widgets/news/all_news.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: CostumDrawer.customDrawer(context),
        bottomNavigationBar: NavBarCommon.navigation(),
        appBar: CommonAppbar.appBar(context),
        body: Column(
          children: [
            EsaySize.gap(7),
            Cat.category(context),
            EsaySize.gap(7),
            AllNews.news(context)
          ],
        ),
      ),
    );
  }
}
