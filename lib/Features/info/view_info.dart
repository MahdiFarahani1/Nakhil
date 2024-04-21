import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Search/controller/search_controller.dart';
import 'package:flutter_application_1/Features/Search/view/view-search.dart';
import 'package:flutter_application_1/Features/info/widgets/widget_us.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';

import 'package:flutter_application_1/Core/utils/esay_size.dart';

import 'package:flutter_application_1/Core/widgets/costum_drawer.dart';
import 'package:flutter_application_1/Core/widgets/coustom-appbar.dart';
import 'package:flutter_application_1/Core/widgets/navbar.dart';

class Info extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final String pageName = "حول التطبیق";

  Info({super.key});

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
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: EsaySize.width(context) * 0.97,
                          height: EsaySize.height(context) * 0.6,
                          decoration: BoxDecoration(
                            color: ConstColor.menuColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                EsaySize.gap(40),

                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "نخيل نيوز، منصة إلكترونية إخبارية تبث أخبارها على مدار الساعة من خلال الويب الخاص بموقعها ومن خلال وسائل التواصل الاجتماعي (فيسبوك/ انستغرام / يوتيوب/ تويتر). يهمنا أن نصنع الخبر ونقدمه بقالب مختلف بحيث نقرأ في أبعاد الخبر وخلفياته، كما يهمنا أن نكون مصدراً للخبر من خلال مقابلات حصرية مع نخب سياسية سواء في الداخل العراقي أو في لبنان وسوريا ومصر والخليج العربي. وإن كانت خطوة الألف ميل تبدأ بخطوة، فإن طموحنا يتخطى حدود عالمنا العربي وصولا الى الدول الإقليمية الفاعلة. وهدفنا كذلك من إنشاء منصة نخيل نيوز أن نصنع الخبر ونضعه في سياق إخباري وسياسي هادف بعيدا عن الاستعراض والسبق الصحفي المثير للنعرات الطائفية والمذهبية والحزبية وكذلك الجدل العقيم بحيث نكون على مسافة واحدة من جميع المكونات وعلى اختلافها وبالتالي نؤسس لنهج إعلامي جديد عبر السوشيل ميديا.",
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(12.0),
                                //   child: Text(
                                //     "https://palms-news.com\ninfo@palms-news.com",
                                //     textAlign: TextAlign.justify,
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .labelMedium!
                                //         .copyWith(
                                //           fontSize: 15,
                                //         ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: Btn.allbtn(context),
                          ),
                        )
                      ],
                    ),
                  )
                : const ViewSearch();
          },
        ),
      ),
    );
  }
}
