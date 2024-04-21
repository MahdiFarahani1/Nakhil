import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/extensions/layout_ex.dart';
import 'package:flutter_application_1/Core/gen/assets.gen.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/Features/articles/view_art.dart';
import 'package:flutter_application_1/Features/home/view/articles.dart';
import 'package:flutter_application_1/Features/home/view/nakhil_home.dart';
import 'package:flutter_application_1/Features/info/repository/aboutus_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

import 'package:share/share.dart';

class CostumDrawer {
  static Widget customDrawer(BuildContext context) {
    ButtonStyle styleBtn() {
      return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          fixedSize: const Size(130, 30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))));
    }

    TextStyle stlebtnText() {
      return const TextStyle(color: Colors.black, fontSize: 14);
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Builder(builder: (context) {
        return Container(
          width: EsaySize.width(context) / 1.8,
          height: EsaySize.height(context) -
              (Scaffold.of(context).appBarMaxHeight!),
          decoration: 10.0.decor(ConstColor.itemBackground),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10)),
                    color: ConstColor.baseColor,
                  ),
                  width: EsaySize.width(context) / 1.8,
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Assets.images.mainLogo.image(),
                      const Text(
                        "الاصدار: 1.1",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              EsaySize.gap(25),
              EsaySize.gap(8),
              ElevatedButton(
                onPressed: () {
                  Get.to(const NakhilHome(),
                      transition: Transition.leftToRight);
                },
                style: styleBtn(),
                child: Text(
                  "الرئيسية",
                  style: stlebtnText(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(const Articles(), transition: Transition.leftToRight);
                },
                style: styleBtn(),
                child: Text(
                  "الاخبار",
                  style: stlebtnText(),
                ),
              ),
              EsaySize.gap(8),
              ElevatedButton(
                onPressed: () {
                  Get.to(const ViewArt(), transition: Transition.leftToRight);
                },
                style: styleBtn(),
                child: Text(
                  "المقالات",
                  style: stlebtnText(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Share.share(
                      "https://play.google.com/store/apps/details?id=com.dijlahit.iraq_palm");
                },
                style: styleBtn(),
                child: FittedBox(
                  child: Text(
                    "مشاركة التطبيق",
                    style: stlebtnText(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  bloc.BlocProvider.of<ControllerApp>(context).state.status
                          is Araghi
                      ? AboutRepository.launchUrl(AboutRepository.urlSiteAraghi)
                      : AboutRepository.launchUrl(AboutRepository.urlSiteNews);
                },
                style: styleBtn(),
                child: FittedBox(
                  child: Text(
                    "الموقع الرسمي",
                    style: stlebtnText(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
